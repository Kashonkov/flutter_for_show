import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

const String AUTHORIZATION_HEADER = "Authorization";
const String AUTHORIZATION_HEADER_PREFIX = "AUTH";

class JsonToTypeConverter implements Converter, ErrorConverter {
  //extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;


  JsonToTypeConverter({
    required this.typeToJsonFactoryMap,

  });

  @override
  Future<Request> convertRequest(Request request) async {
    final req = applyHeaders(
      request,
      {
        contentTypeKey: jsonHeaders,
        AUTHORIZATION_HEADER: "$AUTHORIZATION_HEADER_PREFIX REAL_APP_TOKEN"
      },
      override: true,
    );
    return Future.value(req); //encodeJson(req);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(response, typeToJsonFactoryMap[InnerType]!),
    );
  }

  @override
  Response convertError<BodyType, InnerType>(Response response) => response.copyWith<BodyType>(body: _tryDecodeJson(response));

  T fromJsonData<T, InnerType>(Response response, Function jsonParser) {
    var jsonMap = _tryDecodeJson(response);

    if (jsonMap is List) {
      return jsonMap
          .map(
            (item) => jsonParser(item as Map<String, dynamic>) as InnerType,
          )
          .toList() as T;
    }

    return jsonParser(jsonMap);
  }

  dynamic _tryDecodeJson(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      // If we're decoding JSON, there's some ambiguity in https://tools.ietf.org/html/rfc2616
      // about what encoding should be used if the content-type doesn't contain a 'charset'
      // parameter. See https://github.com/dart-lang/http/issues/186. In a nutshell, without
      // an explicit charset, the Dart http library will fall back to using ISO-8859-1, however,
      // https://tools.ietf.org/html/rfc8259 says that JSON must be encoded using UTF-8. So,
      // we're going to explicitly decode using UTF-8... if we don't do this, then we can easily
      // end up with our JSON string containing incorrectly decoded characters.
      body = utf8.decode(response.bodyBytes);
    }

    try {
      return json.decode(body);
    } catch (e) {
      chopperLogger.warning(e);
      return body;
    }
  }
}
