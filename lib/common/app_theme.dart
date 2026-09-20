// import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

class AppTheme {
  AppTheme._();

  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);

  static final ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: _black,
      primaryContainer: Color(0xFFE5E5E5),
      secondary: _black,
      secondaryContainer: Color(0xFFF2F2F2),
      appBarColor: _white,
      error: Color(0xFFBA1A1A),
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 0,
    useMaterial3: true,
    fontFamily: 'Inter',
  );

  static final ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: _white,
      primaryContainer: Color(0xFF2A2A2A),
      secondary: _white,
      secondaryContainer: Color(0xFF1A1A1A),
      appBarColor: _black,
      error: Color(0xFFFFB4AB),
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 0,
    useMaterial3: true,
    fontFamily: 'Inter',
  );
}
