import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin LocaleTextProvider<P extends StatefulWidget> on State<P>{
  late AppLocalizations local;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    local = AppLocalizations.of(context)!;
  }
}