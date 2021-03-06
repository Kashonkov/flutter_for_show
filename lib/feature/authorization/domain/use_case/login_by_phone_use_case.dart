import 'package:flutter_for_show/core/use_case/use_case.dart';
import 'package:flutter_for_show/feature/authorization/domain/repository/authorization_repository.dart';

class LoginByPhoneUseCase implements UseCase<void, LoginByPhoneUseCaseParams> {
  final AuthorizationRepository repository;

  LoginByPhoneUseCase(this.repository);

  @override
  Future<void> call(LoginByPhoneUseCaseParams params) => repository.loginByPhone(params.login);
}

class LoginByPhoneUseCaseParams {
  final String login;

  LoginByPhoneUseCaseParams({
    required this.login,
  });
}
