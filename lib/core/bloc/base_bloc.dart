import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_talent/core/bloc/news.dart';
import 'package:i_talent/core/bloc/with_state_or_exception.dart';
import 'package:i_talent/core/exceptions/exceptions.dart';
import 'package:i_talent/core/string/string.dart';

abstract class BaseBloc<EventT, StateT extends DefState> extends Bloc<EventT, StateT> {
  final StreamController<BlocNews> _newsController = StreamController.broadcast();
  late Stream<BlocNews> newsStream;

  BaseBloc(StateT initialState) : super(initialState) {
    newsStream = _newsController.stream;
  }

  Stream<StateT> statesOrException(Stream<StateT> Function() func) async* {
    yield* func().transform(StreamTransformer<StateT, StateT>(_onListen));
  }

  StreamSubscription<StateT> _onListen(Stream<StateT> input, bool cancelOnError) {
    late StreamSubscription<StateT> subscription;
    var controller = new StreamController<StateT>(
        onPause: () {
          subscription.pause();
        },
        onResume: () {
          subscription.resume();
        },
        onCancel: () => subscription.cancel(),
        sync: true); // "sync" is correct here, since events are forwarded.
    // Listen to the provided stream using `cancelOnErr
    subscription = input.listen((data) {
      controller.add(data);
    }, onError: (dynamic error, StackTrace stackTrace) {
      if (error is ExceptionWithMessage) {
        debugPrint("stateOrException " + (error.message));
        controller.add(state.failure(error.message));
        onFailure(ErrorBlocNews(error.message));
      } else {
        debugPrint("stateOrException " + stackTrace.toString());
        controller.add(state.failure(errorUnknown));
        onFailure(ErrorBlocNews(error.message ?? errorUnknown));
      }
      controller.close();
    }, onDone: controller.close, cancelOnError: cancelOnError);

    // Return a new [StreamSubscription] by listening to the controller's
    // stream.
    return controller.stream.listen(null);
  }

  @protected
  addNews(BlocNews news) {
    _newsController.add(news);
  }

  @protected
  onFailure(BlocNews news) {
    _newsController.add(news);
  }

  @override
  @mustCallSuper
  Future<void> close() {
    _newsController.close();
    return super.close();
  }
}
