import 'package:i_talent/core/exceptions/exceptions.dart';
import 'package:i_talent/core/network/model/empty_response.dart';
import 'package:i_talent/feature/authorization/data/model/login_response.dart';
import 'package:i_talent/feature/authorization/data/model/request/login_by_phone_request.dart';
import 'package:i_talent/feature/authorization/data/model/request/social_request.dart';
import 'package:i_talent/feature/authorization/data/model/request/auth_request.dart';
import 'package:i_talent/feature/authorization/data/model/request/change_password_request.dart';
import 'package:i_talent/feature/authorization/data/model/request/repeat_sms_request.dart';
import 'package:i_talent/feature/authorization/data/model/request/sms_confirm_request.dart';
import 'package:i_talent/feature/authorization/data/network/net_authorization_service.dart';
import 'package:i_talent/feature/user_info/data/model/user_remote.dart';

abstract class AuthorizationRemoteDataSource {
  Future<LoginResponse> login({required String login, required String password, String? fcmToken});
  Future<UserRemote> registration({required String login, required String password, String? fcmToken});
  Future<LoginResponse> smsConfirmation(String login, String code);
  Future<EmptyResponse> smsRepeat(String login);
  Future<LoginResponse> changePassword({required String login, required String password, required String code});
  Future<LoginResponse> prolongToken();
  Future<LoginResponse> loginByFb(String id, String token);
  Future<LoginResponse> loginByGoogle(String id, String token);
  Future<LoginResponse> loginByApple(String id, String token, String code);
  Future<EmptyResponse> loginByPhone({required String login, String? fcmToken});
}

class AuthorizationRemoteDataSourceImpl implements AuthorizationRemoteDataSource {
  final NetAuthorizationService client;

  AuthorizationRemoteDataSourceImpl(this.client);

  @override
  Future<LoginResponse> login({required String login, required String password, String? fcmToken}) async {
    final request = AuthRequest(
      fcmToken: fcmToken,
      login: login,
      password: password,
    );
    final result = await checkBaseResponse(() async => await client.login(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<UserRemote> registration({required String login, required String password, String? fcmToken}) async{
    final request = AuthRequest(
      fcmToken: fcmToken,
      login: login,
      password: password,
    );
    final result = await checkBaseResponse(() async => await client.registration(request.toJson()), (json) => UserRemote.fromJson(json));
    return result;
  }

  @override
  Future<LoginResponse> smsConfirmation(String login, String code) async{
    final request = SmsConfirmRequest(
      login: login,
      confirmToken: code,
    );
    final result = await checkBaseResponse(() async => await client.smsRegistrationConfirmation(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<EmptyResponse> smsRepeat(String login) async{
    final request = RepeatSmsRequest(
      login: login,
    );
    final result = await checkBaseResponse(() async => await client.sendConfirmationCode(request.toJson()), (json) => EmptyResponse.fromJson(json));
    return result;
  }

  @override
  Future<LoginResponse> changePassword({required String login, required String password, required String code}) async {
    final request = ChangePasswordRequest(
      login: login,
      password: password,
      confirmToken: code
    );
    final result = await checkBaseResponse(() async => await client.changePassword(request.toJson()), (json) => LoginResponse.fromJson(json));
    return result;
  }

  @override
  Future<LoginResponse> prolongToken() async{
    final result = await checkBaseResponse(() async => await client.prolongToken(), (json) => LoginResponse.fromJson(json));
    return result;
  }

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
