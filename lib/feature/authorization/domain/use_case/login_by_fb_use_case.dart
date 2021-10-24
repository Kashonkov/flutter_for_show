import 'package:i_talent/core/use_case/use_case.dart';
import 'package:i_talent/feature/authorization/domain/entity/social_use_case_params.dart';
import 'package:i_talent/feature/authorization/domain/repository/authorization_repository.dart';
import 'package:i_talent/feature/user_info/domain/entity/user_entity.dart';

class LoginByFbUseCase implements UseCase<UserEntity, SocialUseCaseParams>{
  final AuthorizationRepository repository;

  LoginByFbUseCase(this.repository);

  @override
  Future<UserEntity> call(SocialUseCaseParams params) => repository.loginByFB(params.id, params.token);
}