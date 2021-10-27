import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_for_show/core/network/base_response.dart';
import 'package:flutter_for_show/core/network/net_converters.dart';
import 'package:http/io_client.dart';

const String BASE_URL = "https://base_url/api/";

const String HEADER_KEY_CONTENT_TYPE = "Content-Type";
const String HEADER_VALUE_CONTENT_TYPE_UTF8 = "charset=UTF-8";

class NetClient extends ChopperClient {
  NetClient()
      : super(
          client: buildHttpClient(),
          baseUrl: BASE_URL,
          converter: buildConverter(),
          interceptors: buildInterceptors(),
        );

  static IOClient buildHttpClient() {
    HttpClient webHttpClient = new HttpClient()..connectionTimeout = const Duration(seconds: 10);

    webHttpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    return IOClient(webHttpClient);
  }

  static Converter buildConverter() {
    return JsonToTypeConverter(
      typeToJsonFactoryMap: {
        BaseResponse: (json) => BaseResponse.fromJson(json),
      },
    );
  }

  static Iterable buildInterceptors() {
    return [
      // HeadersInterceptor({
      //   HEADER_KEY_CONTENT_TYPE: HEADER_VALUE_CONTENT_TYPE_UTF8,
      // }),
      AuthInfoInterceptor(),
      HttpLoggingInterceptor(),
    ];
  }
}

class AuthInfoInterceptor implements RequestInterceptor {
  const AuthInfoInterceptor();

  @override
  Future<Request> onRequest(Request request) {
    return Future.value(
      applyHeaders(request, {AUTHORIZATION_HEADER: "$AUTHORIZATION_HEADER_PREFIX REAL_APP_TOKEN"}),
    );
  }
}
