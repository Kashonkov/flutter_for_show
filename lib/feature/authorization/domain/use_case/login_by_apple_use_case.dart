import 'package:flutter_for_show/core/use_case/use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/entity/social_use_case_params.dart';
import 'package:flutter_for_show/feature/authorization/domain/repository/authorization_repository.dart';

class LoginByAppleUseCase implements UseCase<void, SocialUseCaseParams>{
  final AuthorizationRepository repository;

  LoginByAppleUseCase(this.repository);

  @override
  Future<void> call(SocialUseCaseParams params) => repository.loginByApple(params.id, params.token, params.code!);
}
