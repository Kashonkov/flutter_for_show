import 'package:i_talent/feature/user_info/domain/entity/user_entity.dart';

abstract class AuthorizationRepository {
  Future<UserEntity> login(String login, String password);

  Future<UserEntity> registration(String login, String password);

  Future<UserEntity> loginByFB(String id, String token);

  Future<UserEntity> loginByGoogle(String id, String token);

  Future<UserEntity> loginByApple(String id, String token, String code);

  Future<void> loginByPhone(String login);

  Future<UserEntity> smsConfirm(String login, String code);

  Future<void> smsRepeat(String login);

  Future<void> prolongToken();

  Future<void> logout();

  Future<UserEntity> changePassword({required String login, required String password, required String token});
}
