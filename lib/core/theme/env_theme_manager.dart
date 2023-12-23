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
    primary: InstaColors.primaryColor,
    //secondary: EnvColors.secondaryColor,
    error: const Color.fromARGB(255, 209, 35, 23),
    background: InstaColors.appBackgroundColor,
    inverseSurface: InstaColors.darkBackgroundColor,
    surface: InstaColors.lightColor,
    onBackground: InstaColors.darkColor,
    onPrimary: InstaColors.lightColor,
    shadow: InstaColors.darkColor,
    onPrimaryContainer: InstaColors.darkColor,
    onInverseSurface: InstaColors.lightColor,
    onSecondary: InstaColors.darkColor,
    onSurface: InstaColors.darkColor,
    onSurfaceVariant: InstaColors.darkColor.withOpacity(0.3),
    onTertiary: InstaColors.darkColor.withOpacity(0.5),
    onErrorContainer: InstaColors.lightColor,
    onTertiaryContainer: InstaColors.lightColor,
    onSecondaryContainer: InstaColors.lightColor,
    brightness: Brightness.light,
    errorContainer: InstaColors.errorColor,
    inversePrimary: InstaColors.primaryColor,
    outline: InstaColors.darkColor,
    outlineVariant: InstaColors.lightColor,
    onError: InstaColors.darkColor,
    primaryContainer: InstaColors.mildLightColor,
    secondary: InstaColors.mildLightColor,
    scrim: InstaColors.lightColor,
    surfaceTint: InstaColors.mildLightColor,
  );
  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: InstaColors.primaryColor,
    error: InstaColors.errorColor,
    background: InstaColors.darkBackgroundColor,
    surface: InstaColors.lightColor,
    onBackground: InstaColors.lightColor,
    onPrimary: InstaColors.lightColor,
    shadow: InstaColors.lightColor,
    onSurface: InstaColors.lightColor,
    onError: InstaColors.lightColor,
    onSecondary: InstaColors.lightColor,
    onInverseSurface: InstaColors.darkColor,
    onPrimaryContainer: InstaColors.lightColor,
    brightness: Brightness.dark,
    errorContainer: InstaColors.errorColor,
    onSecondaryContainer: InstaColors.lightColor,
    onSurfaceVariant: InstaColors.mildGrey,
    onTertiary: InstaColors.lightColor,
    onTertiaryContainer: InstaColors.lightColor,
    primaryContainer: InstaColors.darkColor,
    secondary: InstaColors.mildGrey,
    secondaryContainer: InstaColors.darkColor,
    surfaceVariant: InstaColors.darkColor,
    surfaceTint: InstaColors.mildLightColor,
    scrim: InstaColors.mildGrey,
    tertiary: InstaColors.mildGrey,
    tertiaryContainer: InstaColors.darkColor,
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
      primaryColor: InstaColors.primaryColor,
      backgroundColor: colorScheme.background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: InstaColors.primaryColor,
        cursorColor: InstaColors.primaryColor,
        selectionHandleColor: Colors.blue,
      ),
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
