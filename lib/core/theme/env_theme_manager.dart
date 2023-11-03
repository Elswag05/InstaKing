import 'package:flutter/material.dart';
import 'package:insta_king/core/constants/env_colors.dart';

/// You should assign the textStyle as so => 'textStyle: Theme.of(context).textStyle.textStyleNameAccordingToTheme' e.g Theme.of(context).colorScheme.bodyLarge

class EnvThemeManager {
  EnvThemeManager._();

  static String get _fontFamily => 'Inter';
  static ThemeData lightTheme = _themeData(_lightColorScheme);
  static ThemeData darkTheme = _themeData(_darkColorScheme);

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: EnvColors.primaryColor,
    //secondary: EnvColors.secondaryColor,
    error: EnvColors.errorColor,
    background: EnvColors.appBackgroundColor,
    inverseSurface: EnvColors.darkBackgroundColor,
    surface: EnvColors.secondaryTextColor,
    onBackground: EnvColors.darkColor,
    onPrimary: EnvColors.darkColor,
  );
  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: EnvColors.primaryColor,
    //secondary: EnvColors.secondaryColor,
    error: EnvColors.errorColor,
    background: EnvColors.darkBackgroundColor,
    inverseSurface: EnvColors.lightColor,
    surface: EnvColors.lightColor,
    onBackground: EnvColors.lightColor,
    onPrimary: EnvColors.primaryColor,
  );

  static ThemeData _themeData(ColorScheme colorScheme) => ThemeData(
      scaffoldBackgroundColor: colorScheme.background,
      useMaterial3: false,
      colorScheme: colorScheme,
      iconTheme: _iconTheme(colorScheme),
      fontFamily: _fontFamily,
      appBarTheme: _appBarTheme(colorScheme),
      disabledColor: colorScheme.inverseSurface,
      brightness: colorScheme.brightness,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background,
      ));

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: _iconTheme(colorScheme),
        actionsIconTheme: _iconTheme(colorScheme),
      );

  static IconThemeData _iconTheme(ColorScheme colorScheme) => IconThemeData(
        color: colorScheme.onSurface,
      );
}
