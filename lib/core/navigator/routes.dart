import 'package:flutter/material.dart';
import 'package:flutter_for_show/feature/authorization/di/authorization_module.dart';

class Routes {
  static const String registration = "registration";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registration:
        return _MainPageRoute(page: AuthorizationCompositionRoot.registrationPage());
      default:
        throw UnsupportedError("unknown root: ${settings.name}");
    }
  }
}

const int _HERO_ANIMATION_DURATION = 300;

class _MainPageRoute<T> extends PageRouteBuilder<T> {
  _MainPageRoute({required Widget page, RouteSettings? settings})
      : super(
          opaque: true,
          transitionDuration: Duration(milliseconds: _HERO_ANIMATION_DURATION),
          pageBuilder: (_, __, ___) => page,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
