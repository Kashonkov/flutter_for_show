import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_for_show/app.dart';
import 'package:flutter_for_show/core/network/base_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExceptionWithMessage implements Exception {
  final String message;

  ExceptionWithMessage(this.message);
}

class ServerException extends ExceptionWithMessage {
  final int statusCode;

  ServerException(this.statusCode) : super("$statusCode");
}

class ServerConnectionException extends ExceptionWithMessage {
  ServerConnectionException() : super("Try later");
}

class EmptyDataException extends ExceptionWithMessage {
  EmptyDataException({String? message}) : super(message ?? 'Cache Failure');
}

class ServerJsonException extends ExceptionWithMessage {
  final int errorCode;
  final String errorDesc;

  ServerJsonException(this.errorCode, this.errorDesc) : super(errorDesc);
}

class ServerSessionException extends ExceptionWithMessage {
  final int errorCode;
  final String errorDesc;

  ServerSessionException(this.errorCode, this.errorDesc) : super(errorDesc);
}

Future<T> checkBaseResponse<T>(Future<Response<BaseResponse>> Function() code, T Function(Map<String, dynamic> json) converter) async {
  return await _checkBaseResponseInternally<T>(code, (obj) {
    final result = obj as Map<String, dynamic>;
    return converter(result);
  });
}

Future<List<T>> checkBaseResponseList<T>(Future<Response<BaseResponse>> Function() code, T Function(Map<String, dynamic> json) converter) async {
  return await _checkBaseResponseInternally<List<T>>(code, (obj) {
    final result = obj as List<dynamic>;
    return result.map((e) => converter(e as Map<String, dynamic>)).toList();
  });
}

Future<T> _checkBaseResponseInternally<T>(Future<Response<BaseResponse>> Function() code, Function(Object obj) onSuccess) async {
  Response<BaseResponse> response;
  try {
    response = await code();
  } on SocketException catch (_) {
    throw ExceptionWithMessage(AppLocalizations.of(mainContext)!.net_error);
  } catch (err) {
    throw ExceptionWithMessage(err.toString());
  }

  if (response.statusCode == 200) {
    final resp = response.body;
    if (response.body?.operationResult != "OK") {
      throw ExceptionWithMessage(resp?.operationInfo ?? "");
    }

    return onSuccess(resp!.object);
  } else if (response != null) {
    if (response.statusCode == 500 && response.error is String) {
      var respJson = json.decode(response.error as String);
      final resp = BaseResponse.fromJson(respJson);
      throw ExceptionWithMessage(resp.operationInfo);
    }
    throw ServerException(response.statusCode);
  } else {
    throw ServerConnectionException();
  }
}

Future<T> checkNetErrors<T>(Future<Response<T>?> Function() code) async {
  Response<T>? response;
  try {
    response = await code();
  } catch (err, stackTrace) {
    print("err: ${stackTrace.toString()}");
    print("err: ${err.toString()}");
    throw ExceptionWithMessage(err.toString());
  }
  if (response != null && response.statusCode == 200) {
    return response.body!;
  } else if (response != null) {
    throw ServerException(response.statusCode);
  } else {
    throw ServerConnectionException();
  }
}
