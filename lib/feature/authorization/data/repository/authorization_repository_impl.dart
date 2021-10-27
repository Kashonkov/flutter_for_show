import 'package:flutter_for_show/feature/authorization/data/datasource/auth_info_provider.dart';
import 'package:flutter_for_show/feature/authorization/data/datasource/remote_data_source.dart';
import 'package:flutter_for_show/feature/authorization/domain/repository/authorization_repository.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final AuthorizationRemoteDataSource remoteDataSource;
  final AuthInfoProvider authInfoProvider;

  AuthorizationRepositoryImpl({
    required this.remoteDataSource,
    required this.authInfoProvider,
  });

  @override
  Future<void> loginByFB(String id, String token) async{
    final result = await remoteDataSource.loginByFb(id, token);
    await authInfoProvider.setToken(result.jwtToken);
  }

  @override
  Future<void> loginByGoogle(String id, String token) async{
    final result = await remoteDataSource.loginByGoogle(id, token);
    await authInfoProvider.setToken(result.jwtToken);
  }

  @override
  Future<void> loginByApple(String id, String token, String code) async{
    final result = await remoteDataSource.loginByApple(id, token, code);
    await authInfoProvider.setToken(result.jwtToken);
  }

  @override
  Future<void> loginByPhone(String login) async{
    await remoteDataSource.loginByPhone(login: login,fcmToken: "");
  }
}
