import 'package:flutter_for_show/core/use_case/use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/entity/social_use_case_params.dart';
import 'package:flutter_for_show/feature/authorization/domain/repository/authorization_repository.dart';

class LoginByGoogleUseCase implements UseCase<void, SocialUseCaseParams>{
  final AuthorizationRepository repository;

  LoginByGoogleUseCase(this.repository);

  @override
  Future<void> call(SocialUseCaseParams params) => repository.loginByGoogle(params.id, params.token);
}
