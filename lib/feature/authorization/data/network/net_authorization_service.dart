import 'package:chopper/chopper.dart';
import 'package:i_talent/core/network/model/base_response.dart';
import 'package:i_talent/core/network/net_client.dart';
import 'package:i_talent/core/network/urls.dart';

part 'net_authorization_service.chopper.dart';

@ChopperApi()
abstract class NetAuthorizationService extends ChopperService {
  static NetAuthorizationService create(NetClient client) =>
      _$NetAuthorizationService(client);

  @Post(path: Urls.login)
  Future<Response<BaseResponse>> login(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.registration)
  Future<Response<BaseResponse>> registration(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.sms_registration_confirmation)
  Future<Response<BaseResponse>> smsRegistrationConfirmation(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.send_confirmation_code)
  Future<Response<BaseResponse>> sendConfirmationCode(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.change_password)
  Future<Response<BaseResponse>> changePassword(@QueryMap() Map<String, dynamic> req);

  @Get(path: Urls.token_prolongation)
  Future<Response<BaseResponse>> prolongToken();

  @Post(path: Urls.login_by_fb)
  Future<Response<BaseResponse>> loginByFb(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_google)
  Future<Response<BaseResponse>> loginByGoogle(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_apple)
  Future<Response<BaseResponse>> loginByApple(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_phone)
  Future<Response<BaseResponse>> loginByPhone(@QueryMap() Map<String, dynamic> req);
}

