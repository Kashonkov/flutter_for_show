import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_talent/core/bloc/bloc_instance_provider.dart';
import 'package:i_talent/feature/authorization/data/datasource/remote_data_source.dart';
import 'package:i_talent/feature/authorization/data/network/net_authorization_service.dart';
import 'package:i_talent/feature/authorization/data/repository/authorization_repository_impl.dart';
import 'package:i_talent/feature/authorization/domain/repository/authorization_repository.dart';
import 'package:i_talent/feature/authorization/domain/use_case/change_password_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_apple_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_fb_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_google_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_by_phone_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/login_usecase.dart';
import 'package:i_talent/feature/authorization/domain/use_case/logout_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/prolong_token_use_case.dart';
import 'package:i_talent/feature/authorization/domain/use_case/registration_usecase.dart';
import 'package:i_talent/feature/authorization/domain/use_case/sms_confirm_usecase.dart';
import 'package:i_talent/feature/authorization/domain/use_case/sms_repeat_use_case.dart';
import 'package:i_talent/feature/authorization/presentation/login_page/bloc/login_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/login_page/login_page.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/new_password/bloc/new_password_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/new_password/new_password_page.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/password_recovery_login/bloc/password_recovery_login_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/password_recovery_login/password_recovery_login_page.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/password_recovery_sms/bloc/password_recovery_sms_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/password_recovery/password_recovery_sms/password_recovery_sms_page.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/registration_page.dart';
import 'package:i_talent/feature/authorization/presentation/registration/sms_confirm_page/bloc/sms_confirm_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/registration/sms_confirm_page/sms_confirm_page.dart';

class AuthorizationModule extends BaseDimeModule {
  @override
  void updateInjections() {
    //region Net
    addSingleByCreator<NetAuthorizationService>((tag) => NetAuthorizationService.create(dimeGet()));

    //region DataSource
    addSingleByCreator<AuthorizationRemoteDataSource>((tag) => AuthorizationRemoteDataSourceImpl(dimeGet()));

    //region Repository
    addSingleByCreator<AuthorizationRepository>(
      (tag) => AuthorizationRepositoryImpl(
        remoteDataSource: dimeGet(),
        authInfoProvider: dimeGet(),
        saveUserInfoUseCase: dimeGet(),
        mainRepository: dimeGet(),
        updateDictionariesUseCase: dimeGet(),
        pushNotificationsHelper: dimeGet(),
      ),
    );
    //region UseCase
    addSingleByCreator<LoginUseCase>((tag) => LoginUseCase(dimeGet()));
    addSingleByCreator<LoginByFbUseCase>((tag) => LoginByFbUseCase(dimeGet()));
    addSingleByCreator<LoginByPhoneUseCase>((tag) => LoginByPhoneUseCase(dimeGet()));
    addSingleByCreator<LoginByGoogleUseCase>((tag) => LoginByGoogleUseCase(dimeGet()));
    addSingleByCreator<LoginByAppleUseCase>((tag) => LoginByAppleUseCase(dimeGet()));
    addSingleByCreator<RegistrationUseCase>((tag) => RegistrationUseCase(dimeGet()));
    addSingleByCreator<SmsConfirmUseCase>((tag) => SmsConfirmUseCase(dimeGet()));
    addSingleByCreator<SmsRepeatUseCase>((tag) => SmsRepeatUseCase(dimeGet()));
    addSingleByCreator<ChangePasswordUseCase>((tag) => ChangePasswordUseCase(dimeGet()));
    addSingleByCreator<ProlongTokenUseCase>((tag) => ProlongTokenUseCase(dimeGet()));
    addSingleByCreator<LogoutUseCase>((tag) => LogoutUseCase(dimeGet()));

    //regionBloc
    addCreator<LoginBloc>((tag) => LoginBloc(loginUseCase: dimeGet()));

    addCreator<RegistrationBloc>((tag) => RegistrationBloc(
          updateUserInfoUseCase: dimeGet(),
          registrationUseCase: dimeGet(),
          loginByFbUseCase: dimeGet(),
          loginByGoogleUseCase: dimeGet(),
          loginByAppleUseCase: dimeGet(),
          loginByPhoneUseCase: dimeGet(),
        ));
    addCreator<PasswordRecoveryLoginBloc>((tag) => PasswordRecoveryLoginBloc(useCase: dimeGet()));
  }
}

class AuthorizationCompositionRoot {
  static Widget loginPage() => BlocProvider(
        create: (_) => dimeGet<LoginBloc>(),
        child: LoginPage(),
      );

  static Widget registrationPage() => BlocProvider(
        create: (_) => dimeGet<RegistrationBloc>(),
        child: RegistrationPage(),
      );

  static Widget smsConfirmPage(String login) {
    return BlocProvider(
        create: (_) => SmsConfirmBloc(
            login: login,
            smsRegistrationConfirmUseCase: dimeGet(),
            smsRepeatUseCase: dimeGet(),
            updateUserInfoUseCase: dimeGet()),
        child: SmsConfirmPage());
  }

  static Widget passwordRecoveryLoginPage() => BlocProvider(
        create: (_) => dimeGet<PasswordRecoveryLoginBloc>(),
        child: PasswordRecoveryLoginPage(),
      );

  static Widget passwordRecoverySmsPage(String login) {
    return BlocProvider(
        create: (_) => PasswordRecoverySmsBloc(
              login: login,
              smsRepeatUseCase: dimeGet(),
            ),
        child: PasswordRecoverySmsPage());
  }

  static Widget passwordRecoveryNewPassword({required String login, required String token}) {
    return BlocProvider(
      create: (_) => NewPasswordBloc(
        token: token,
        login: login,
        changePasswordUseCase: dimeGet(),
      ),
      child: NewPasswordPage(),
    );
  }
}
