import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:i_talent/feature/authorization/domain/entity/social_use_case_params.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_apple_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_fb_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_google_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_phone_use_case.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/registration_step.dart';
import 'package:i_talent/feature/user_info/domain/entity/user_entity.dart';
import 'package:i_talent/feature/user_info/domain/use_case/update_user_info.dart';
import 'package:i_talent/navigator/main_navigator.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_talent/app.dart';
import 'package:i_talent/core/bloc/base_bloc.dart';
import 'package:i_talent/core/bloc/news.dart';
import 'package:i_talent/core/extensions/string_extensions.dart';
import 'package:i_talent/feature/authorization/domain/use_case/registration_usecase.dart';
import 'package:i_talent/feature/authorization/presentation/authorization_navigator.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_event.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_state.dart';

class RegistrationBloc extends BaseBloc<RegistrationEvent, RegistrationState> {
  final RegistrationUseCase registrationUseCase;
  final LoginByFbUseCase loginByFbUseCase;
  final LoginByGoogleUseCase loginByGoogleUseCase;
  final LoginByAppleUseCase loginByAppleUseCase;
  final LoginByPhoneUseCase loginByPhoneUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;

  RegistrationBloc({
    required this.registrationUseCase,
    required this.loginByFbUseCase,
    required this.loginByGoogleUseCase,
    required this.loginByAppleUseCase,
    required this.loginByPhoneUseCase,
    required this.updateUserInfoUseCase,
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

  Stream<RegistrationState> _registerUser(String login, String password, String repeatedPassword) async* {
    yield* statesOrException(() async* {
      if (login.isNullOrEmpty()) {
        addNews(ErrorBlocNews(AppLocalizations.of(mainContext)!.empty_login_error));
        return;
      } else if (password.isNullOrEmpty()) {
        addNews(ErrorBlocNews(AppLocalizations.of(mainContext)!.empty_password_error));
        return;
      } else if (password != repeatedPassword) {
        addNews(ErrorBlocNews(AppLocalizations.of(mainContext)!.password_are_not_equals));
        return;
      }
      yield state.loading();
      final cleanLogin = "+${login.replaceAll(RegExp(r'\D'), "")}";
      await registrationUseCase(RegistrationUseCaseParams(
        login: cleanLogin,
        password: password,
      ));
      yield state.stopLoading();
      AuthorizationNavigator.navigateToSmsConfirm(cleanLogin);
    });
  }

  Stream<RegistrationState> _signInWithPhone(String phone) async* {
    yield* statesOrException(() async* {
      yield state.loading();
      final cleanPhone = state.phoneNumber!.dialCode! + phone.clearNotDigits();
      await loginByPhoneUseCase(LoginByPhoneUseCaseParams(
        login: cleanPhone,
      ));
      yield state.stopLoading();
      AuthorizationNavigator.navigateToSmsConfirm(cleanPhone);
    });
  }

  Stream<RegistrationState> _signInWithGoogle() async* {
    yield* statesOrException(() async* {
      yield state.loading();
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      UserEntity user = await loginByGoogleUseCase(SocialUseCaseParams(id: googleUser.id, token: googleAuth.idToken));
      user = await updateFirstEntry(user);

      yield state.setRegistrationSuccessful();
      await Future.delayed(Duration(seconds: 1), () {
        navigateNext(user);
      });
    }); // Trigger the authentication flow
  }

  Stream<RegistrationState> _signInWithFacebook() async* {
    yield* statesOrException(() async* {
      yield state.loading();
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        UserEntity user = await loginByFbUseCase(
            SocialUseCaseParams(id: loginResult.accessToken!.userId, token: loginResult.accessToken!.token));

        user = await updateFirstEntry(user);

        yield state.setRegistrationSuccessful();
        await Future.delayed(Duration(seconds: 1), () {
          navigateNext(user);
        });
      } else {
        yield state.stopLoading();
      }
    }); // Trigger the authentication flow
  }

  navigateNext(UserEntity user) {
    if (user.firstEntry != null && user.firstEntry!) {
      MainNavigator.navigateToInitialProfileSettings(user);
    } else {
      MainNavigator.navigateToMain();
    }
  }

  Future<UserEntity> updateFirstEntry(UserEntity user) async {
    UserEntity newUser = user;
    if (user.firstEntry != null && user.firstEntry!) {
      await updateUserInfoUseCase(UpdateUserInfoUseCaseParams(user: user.copyWith(firstEntry: false)));
    }
    return newUser;
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
        UserEntity user = await loginByAppleUseCase(SocialUseCaseParams(
            id: appleCredential.userIdentifier!,
            token: appleCredential.identityToken!,
            code: appleCredential.authorizationCode));

        user = await updateFirstEntry(user);

        yield state.setRegistrationSuccessful();
        await Future.delayed(Duration(seconds: 1), () {
          navigateNext(user);
        });
      } else {
        yield state.stopLoading();
      }
    });
  }
}
