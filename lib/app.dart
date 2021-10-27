import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_for_show/core/colors.dart';
import 'package:flutter_for_show/core/navigator/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>();

NavigatorState? get mainNavigator => mainNavigatorKey.currentState;

BuildContext get mainContext => mainNavigator!.context;


class FlutterForShowApp extends StatefulWidget {
  const FlutterForShowApp({Key? key}) : super(key: key);

  @override
  State createState() => FlutterForShowAppState();
}

class FlutterForShowAppState extends State<FlutterForShowApp> {
  final TextTheme defaultTheme = Typography.material2018(platform: defaultTargetPlatform).englishLike;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColorsNew.surface));
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('ru', ''),
      ],
      builder: (BuildContext context, Widget? child) {
        var nativeFactor = MediaQuery.of(context).textScaleFactor;
        if (nativeFactor >= 1.10) nativeFactor = 1.10;
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: nativeFactor), child: child!);
      },
      theme: ThemeData(
        brightness: Brightness.light,
        applyElevationOverlayColor: false,
        colorScheme: const ColorScheme.light(
          primary: AppColorsNew.primary,
          primaryVariant: AppColorsNew.primaryVariant,
          secondary: AppColorsNew.secondary,
          secondaryVariant: AppColorsNew.secondaryVariant,
          surface: AppColorsNew.surface,
          background: AppColorsNew.background,
          error: AppColorsNew.error,
          onPrimary: AppColorsNew.onPrimary,
          onSecondary: AppColorsNew.onSecondary,
          onSurface: AppColorsNew.onSurface,
          onBackground: AppColorsNew.onBackground,
          onError: AppColorsNew.onError,
        ),
        textTheme: TextTheme(
          headline1: defaultTheme.headline1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            height: 1.22,
            fontFamily: 'Roboto',
          ),
          headline2: defaultTheme.headline2!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            height: 1.22,
            fontFamily: 'Roboto',
          ),
          headline3: defaultTheme.headline3!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            height: 1.14,
            fontFamily: 'Roboto',
          ),
          headline4: defaultTheme.headline4!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            height: 1.22,
            fontFamily: 'Roboto',
          ),
          bodyText1: defaultTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          bodyText2: defaultTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          button: defaultTheme.button!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          subtitle1: defaultTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.22,
            fontFamily: 'Roboto',
          ),
          caption: defaultTheme.caption!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'Roboto',
            color: AppColorsNew.optional2,
          ),
        ),
      ),
      title: '',
      debugShowCheckedModeBanner: false,
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.registration,
    );
  }
}
