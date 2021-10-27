import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_show/app.dart';
import 'package:flutter_for_show/core/di/main_module.dart';
import 'package:logging/logging.dart';
import 'package:flutter_for_show/feature/authorization/di/authorization_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  await initDime();

  runApp(FlutterForShowApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

Future<void> initDime() async {
  dimeInstall(CommonServicesDimeModule());
  dimeInstall(AuthorizationModule());
}
