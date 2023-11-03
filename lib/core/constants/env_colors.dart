import 'package:flutter/material.dart';

/// Color Guide Notice (Primary ORANGE, INFO COLOR)
/// Ranging from (50-900)
/// 50 = Light, 100 = Light :hover, 200 = Light :active,
/// 300 = Normal, 400 = Normal :hover, 500 = Normal :active,
/// 600 = Dark, 700 = Dark :hover, 800 = Dark :active, 800 = Darker

/// Color Guide Notice (GREYS)
/// Ranging from (50-900)
/// 50 = Normal, 100 = Normal :hover, 200 = Normal :active,
/// 300 = Dark, 400 = Dark :hover, 500 = Dark :active,
/// 600 = Darker, 700 = Dark :hover, 800 = Dark :active, 800 = Darker

class EnvColors {
  EnvColors._();

  static Color appBackgroundColor = const Color.fromARGB(255, 255, 237, 232);
  static Color darkBackgroundColor = const Color.fromARGB(255, 0, 0, 0);
  static Color darkColor = const Color.fromARGB(255, 0, 0, 0);
  static const MaterialColor errorColor = MaterialColor(
    _errorColorValue,
    <int, Color>{
      50: Color(0xFFFDEEEE),
      100: Color(0xFFFCE6E6),
      200: Color(0xFFF9CBCB),
      300: Color(_errorColorValue),
      400: Color(0xFFD44E4E),
      500: Color(0xFFBC4646),
      600: Color(0xFFB04141),
      700: Color(0xFF8D3434),
      800: Color(0xFF6A2727),
      900: Color(0xFF521E1E),
    },
  );

  static Color lightColor = const Color(0xffffffff);
  static const Color mildGrey = Color(0xfff7f7f7);
  static const MaterialColor primaryColor =
      MaterialColor(_primaryColorValue, <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(0xFFFFA776), // Your custom color: rgb(254, 85, 46)
    600: Color(0xFFFB8C00),
    700: Color(0xFFF57C00),
    800: Color(0xFFEF6C00),
    900: Color(0xFFE65100),
  });

  static Color secondaryTextColor = const Color(0xff53505b);

  static const int _errorColorValue = 0xFFB42318;
  static const int _primaryColorValue = 0xFFE65100;
}
