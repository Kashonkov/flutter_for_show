import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_for_show/core/bloc/base_bloc.dart';
import 'package:flutter_for_show/core/bloc/news.dart';
import 'package:flutter_for_show/core/widgets/dialog.dart';

abstract class StateWithBloc<T extends BaseBloc, P extends StatefulWidget> extends State<P> {
  late T bloc;
  StreamSubscription? subscription;


  @override
  @mustCallSuper
  void initState() {
    super.initState();
    bloc = BlocProvider.of<T>(context);
    subscription = bloc.newsStream.listen((event) => onNewsReceived(event));
  }

  @override
  @mustCallSuper
  void dispose() {
    subscription?.cancel();
    bloc.close();
    super.dispose();
  }


  @protected
  void onNewsReceived(BlocNews news){
    if(news is ErrorBlocNews){
      showErrorDialog(context: context, message: news.errorMessage);
    }
  }
}