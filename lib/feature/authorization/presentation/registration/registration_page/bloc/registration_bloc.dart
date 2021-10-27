import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_for_show/core/extensions/string_extensions.dart';
import 'package:flutter_for_show/core/bloc/base_bloc.dart';
import 'package:flutter_for_show/feature/authorization/domain/entity/social_use_case_params.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_apple_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_fb_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_google_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_phone_use_case.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_event.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_state.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/registration_step.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegistrationBloc extends BaseBloc<RegistrationEvent, RegistrationState> {
  final LoginByFbUseCase loginByFbUseCase;
  final LoginByGoogleUseCase loginByGoogleUseCase;
  final LoginByAppleUseCase loginByAppleUseCase;
  final LoginByPhoneUseCase loginByPhoneUseCase;

  RegistrationBloc({
    required this.loginByFbUseCase,
    required this.loginByGoogleUseCase,
    required this.loginByAppleUseCase,
    required this.loginByPhoneUseCase,
  }) : super(RegistrationState.initial());

  @override
  Stream<RegistrationState> mapEventToState(event) async* {
    if (event is OnRegisterClickedEvent) {
      yield* _signInWithPhone(event.phone);
    } else if (event is AcceptedTermsEvent) {
      yield state.setTermsAccepted(event.isAccepted);
    } else if (event is OnRegisterButtonClickedEvent) {
      yield state.setStep(RegistrationStep.phone_input);
    } else if (event is OnBackClickedEvent) {
      yield state.setStep(RegistrationStep.welcome).setCanSend(false).setPhoneNumber(null);
    } else if (event is OnPhoneChangeEvent) {
      yield _checkPhone(event.value.phoneNumber ?? "").setPhoneNumber(event.value);
    } else if (event is OnGoogleCLickedEvent) {
      yield* _signInWithGoogle();
    } else if (event is OnAppleCLickedEvent) {
      yield* _signInWithApple();
    } else if (event is OnFacebookCLickedEvent) {
      yield* _signInWithFacebook();
    } else if (event is OnTermsNextCLicked) {
      yield state.setStep(RegistrationStep.welcome);
    }
  }

  RegistrationState _checkPhone(String phone) {
    if (phone.clearNotDigits().length >= 11) {
      return state.setCanSend(true);
    } else {
      return state.setCanSend(false);
    }
  }

  Stream<RegistrationState> _signInWithPhone(String phone) async* {
    yield* statesOrException(() async* {
      yield state.loading();
      final cleanPhone = state.phoneNumber!.dialCode! + phone.clearNotDigits();
      await loginByPhoneUseCase(LoginByPhoneUseCaseParams(
        login: cleanPhone,
      ));
      yield state.stopLoading();
    });
  }

  Stream<RegistrationState> _signInWithGoogle() async* {
    yield* statesOrException(() async* {
      yield state.loading();
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      await loginByGoogleUseCase(SocialUseCaseParams(id: googleUser.id, token: googleAuth.idToken));

      yield state.setRegistrationSuccessful();
    }); // Trigger the authentication flow
  }

  Stream<RegistrationState> _signInWithFacebook() async* {
    yield* statesOrException(() async* {
      yield state.loading();
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
         await loginByFbUseCase(
            SocialUseCaseParams(id: loginResult.accessToken!.userId, token: loginResult.accessToken!.token));

         yield state.setRegistrationSuccessful();
      } else {
        yield state.stopLoading();
      }
    }); // Trigger the authentication flow
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Stream<RegistrationState> _signInWithApple() async* {
    yield* statesOrException(() async* {
      yield state.loading();
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = _generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      if (appleCredential.userIdentifier != null && appleCredential.identityToken != null) {
        await loginByAppleUseCase(SocialUseCaseParams(
            id: appleCredential.userIdentifier!,
            token: appleCredential.identityToken!,
            code: appleCredential.authorizationCode));

        yield state.setRegistrationSuccessful();
      } else {
        yield state.stopLoading();
      }
    });
  }
}
