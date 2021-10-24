import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_talent/core/exceptions/exceptions.dart';
import 'package:i_talent/core/resources/string.dart';
import 'package:logging/logging.dart';

mixin DefState<T> {
  ErrorMessage? get errorMessage;

  bool get isLoading;

  T failure(String message);
}

class ErrorMessage{
  final String message;

  ErrorMessage(this.message);
}
