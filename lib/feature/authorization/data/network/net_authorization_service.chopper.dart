// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_authorization_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NetAuthorizationService extends NetAuthorizationService {
  _$NetAuthorizationService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NetAuthorizationService;

  @override
  Future<Response<BaseResponse>> loginByFb(Map<String, dynamic> req) {
    final $url = 'user/loginFacebook';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> loginByGoogle(Map<String, dynamic> req) {
    final $url = 'user/loginGoogle';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> loginByApple(Map<String, dynamic> req) {
    final $url = 'user/loginApple';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> loginByPhone(Map<String, dynamic> req) {
    final $url = 'user/loginCode';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }
}
