abstract class AuthInfoProvider{
  Future<void> setToken(String token);
}

class AuthInfoProviderImpl implements AuthInfoProvider{
  @override
  Future<void> setToken(String token) async{
  }

}