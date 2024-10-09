import 'package:flutter/material.dart';
import 'package:minimal_notes_app/app/shared/theme/app_colors.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: colorBackgroundLight,
    primary: colorPrimaryLight,
    secondary: colorSecondaryLight,
    inversePrimary: colorInversePrimaryLight
  )
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: colorBackgroundDark,
    primary: colorPrimaryDark,
    secondary: colorSecondaryDark,
    inversePrimary: colorInversePrimaryDark,
  )
);