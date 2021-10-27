import 'package:flutter_for_show/core/exceptions/exceptions.dart';
import 'package:flutter_for_show/core/network/empty_response.dart';
import 'package:flutter_for_show/feature/authorization/data/model/login_response.dart';
import 'package:flutter_for_show/feature/authorization/data/model/request/login_by_phone_request.dart';
import 'package:flutter_for_show/feature/authorization/data/model/request/social_request.dart';
import 'package:flutter_for_show/feature/authorization/data/network/net_authorization_service.dart';

abstract class AuthorizationRemoteDataSource {
  Future<LoginResponse> loginByFb(String id, String token);
  Future<LoginResponse> loginByGoogle(String id, String token);
  Future<LoginResponse> loginByApple(String id, String token, String code);
  Future<EmptyResponse> loginByPhone({required String login, String? fcmToken});
}

class AuthorizationRemoteDataSourceImpl implements AuthorizationRemoteDataSource {
  final NetAuthorizationService client;

  AuthorizationRemoteDataSourceImpl(this.client);

  @override
  Future<LoginResponse> loginByFb(String id, String token) async{
    final request = SocialRequest(
      userId: id,
      token: token,
    );
    final result = await checkBaseResponse(() async => await client.loginByFb(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<LoginResponse> loginByGoogle(String id, String token) async{
    final request = SocialRequest(
      userId: id,
      token: token,
    );
    final result = await checkBaseResponse(() async => await client.loginByGoogle(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<LoginResponse> loginByApple(String id, String token, String code) async{
    final request = SocialRequest(
      userId: id,
      token: token,
      code: code,
    );
    final result = await checkBaseResponse(() async => await client.loginByApple(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<EmptyResponse> loginByPhone({required String login, String? fcmToken}) async{
    final request = LoginByPhoneRequest(
      login: login,
      fcmToken: fcmToken,
    );
    final result = await checkBaseResponse(() async => await client.loginByPhone(request.toJson()), (json) => EmptyResponse.fromJson(json));
    return result;
  }
}
