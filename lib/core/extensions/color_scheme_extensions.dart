import 'package:flutter/material.dart';
import 'package:i_talent/core/resources/colors.dart';

extension ExtendedColorScheme on ColorScheme {
  Color get backButtonColor => AppColors.backButtonColor;
  Color get underline => AppColors.underline;
  Color get underlineFocused => AppColors.underlineFocused;
  Color get lightBackground => AppColors.errorBackground;
  Color get errorSmileColor => AppColors.errorSmileColor;
  Color get unselectedNavigationItem => AppColors.unselectedNavigationItem;
  Color get bottomNavigation => AppColors.bottomNavigationBackground;
  Color get imageBorderColor => Colors.white;
  Color get transparentPhotoForeground => AppColors.transparentPhotoForeground;
  Color get transparentDarkBackground => AppColors.transparentPhotoDarkForeground;
}


extension NewExtendedColorScheme on ColorScheme {
  Color get primaryVariant2 => AppColorsNew.primaryVariant2;
  Color get onPrimary2 => AppColorsNew.onPrimary2;
  Color get onPrimary3 => AppColorsNew.onPrimary3;
  Color get secondaryVariant2 => AppColorsNew.secondaryVariant2;
  Color get onSecondary2 => AppColorsNew.onSecondary2;
  Color get onSecondary3 => AppColorsNew.onSecondary3;
  Color get onError2 => AppColorsNew.onError2;
  Color get optional => AppColorsNew.optional;
  Color get optional2 => AppColorsNew.optional2;
}
