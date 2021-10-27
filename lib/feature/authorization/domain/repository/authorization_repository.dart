abstract class AuthorizationRepository {
  Future<void> loginByFB(String id, String token);

  Future<void> loginByGoogle(String id, String token);

  Future<void> loginByApple(String id, String token, String code);

  Future<void> loginByPhone(String login);
}
