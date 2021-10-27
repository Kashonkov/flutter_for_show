import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_for_show/feature/authorization/data/datasource/auth_info_provider.dart';
import 'package:flutter_for_show/feature/authorization/data/datasource/remote_data_source.dart';
import 'package:flutter_for_show/feature/authorization/data/network/net_authorization_service.dart';
import 'package:flutter_for_show/feature/authorization/data/repository/authorization_repository_impl.dart';
import 'package:flutter_for_show/feature/authorization/domain/repository/authorization_repository.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_apple_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_fb_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_google_use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/use_case/login_by_phone_use_case.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_bloc.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/registration_page.dart';

class AuthorizationModule extends BaseDimeModule {
  @override
  void updateInjections() {
    //region Net
    addSingleByCreator<NetAuthorizationService>((tag) => NetAuthorizationService.create(dimeGet()));

    //region DataSource
    addSingleByCreator<AuthorizationRemoteDataSource>((tag) => AuthorizationRemoteDataSourceImpl(dimeGet()));
    addSingleByCreator<AuthInfoProvider>((tag) => AuthInfoProviderImpl());

    //region Repository
    addSingleByCreator<AuthorizationRepository>(
      (tag) => AuthorizationRepositoryImpl(
        remoteDataSource: dimeGet(),
        authInfoProvider: dimeGet(),
      ),
    );
    //region UseCase
    addSingleByCreator<LoginByFbUseCase>((tag) => LoginByFbUseCase(dimeGet()));
    addSingleByCreator<LoginByPhoneUseCase>((tag) => LoginByPhoneUseCase(dimeGet()));
    addSingleByCreator<LoginByGoogleUseCase>((tag) => LoginByGoogleUseCase(dimeGet()));
    addSingleByCreator<LoginByAppleUseCase>((tag) => LoginByAppleUseCase(dimeGet()));


    addCreator<RegistrationBloc>((tag) => RegistrationBloc(
          loginByFbUseCase: dimeGet(),
          loginByGoogleUseCase: dimeGet(),
          loginByAppleUseCase: dimeGet(),
          loginByPhoneUseCase: dimeGet(),
        ));
  }
}

class AuthorizationCompositionRoot {
  static Widget registrationPage() => BlocProvider(
        create: (_) => dimeGet<RegistrationBloc>(),
        child: RegistrationPage(),
      );
}
