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
  Future<Response<BaseResponse>> login(Map<String, dynamic> req) {
    final $url = 'user/login';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> registration(Map<String, dynamic> req) {
    final $url = 'user/registration';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> smsRegistrationConfirmation(
      Map<String, dynamic> req) {
    final $url = 'user/confirmation';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> sendConfirmationCode(
      Map<String, dynamic> req) {
    final $url = 'user/confirmationCode';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> changePassword(Map<String, dynamic> req) {
    final $url = 'user/passwordChanging';
    final $params = req;
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<BaseResponse, BaseResponse>($request);
  }

  @override
  Future<Response<BaseResponse>> prolongToken() {
    final $url = 'user/tokenProlongation';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BaseResponse, BaseResponse>($request);
  }

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
