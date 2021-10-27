import 'package:chopper/chopper.dart';
import 'package:flutter_for_show/core/network/base_response.dart';
import 'package:flutter_for_show/core/network/net_client.dart';
import 'package:flutter_for_show/core/network/urls.dart';

part 'net_authorization_service.chopper.dart';

@ChopperApi()
abstract class NetAuthorizationService extends ChopperService {
  static NetAuthorizationService create(NetClient client) =>
      _$NetAuthorizationService(client);

  @Post(path: Urls.login_by_fb)
  Future<Response<BaseResponse>> loginByFb(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_google)
  Future<Response<BaseResponse>> loginByGoogle(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_apple)
  Future<Response<BaseResponse>> loginByApple(@QueryMap() Map<String, dynamic> req);

  @Post(path: Urls.login_by_phone)
  Future<Response<BaseResponse>> loginByPhone(@QueryMap() Map<String, dynamic> req);
}

