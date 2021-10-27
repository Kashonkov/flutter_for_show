import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter_for_show/core/network/net_client.dart';

class CommonServicesDimeModule extends BaseDimeModule {
  @override
  void updateInjections() {
    addSingleByCreator((tag) => NetClient());
  }
}