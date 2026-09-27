import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);

  static TextTheme _textTheme(Color color, Color mutedColor) {
    final base = GoogleFonts.spaceGroteskTextTheme();

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: color, fontSize: 14),
      bodyMedium: base.bodyMedium?.copyWith(color: mutedColor, fontSize: 14),
      bodySmall: base.bodySmall?.copyWith(color: mutedColor, fontSize: 12),
      labelLarge: base.labelLarge?.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: mutedColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static final ThemeData light = _buildTheme(
    brightness: Brightness.light,
    primary: _black,
    onPrimary: _white,
    primaryContainer: const Color(0xFFE5E5E5),
    onPrimaryContainer: _black,
    secondary: _black,
    onSecondary: _white,
    secondaryContainer: const Color(0xFFF2F2F2),
    onSecondaryContainer: _black,
    surface: _white,
    onSurface: _black,
    appBarColor: _white,
    onAppBarColor: _black,
    error: const Color(0xFFBA1A1A),
    onError: _white,
    scaffoldBackground: _white,
    textColor: _black,
    mutedTextColor: Colors.black45,
  );

  static final ThemeData dark = _buildTheme(
    brightness: Brightness.dark,
    primary: _white,
    onPrimary: _black,
    primaryContainer: const Color(0xFF2A2A2A),
    onPrimaryContainer: _white,
    secondary: _white,
    onSecondary: _black,
    secondaryContainer: const Color(0xFF1A1A1A),
    onSecondaryContainer: _white,
    surface: _black,
    onSurface: _white,
    appBarColor: _black,
    onAppBarColor: _white,
    error: const Color(0xFFFFB4AB),
    onError: _black,
    scaffoldBackground: _black,
    textColor: _white,
    mutedTextColor: Colors.white70,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color secondary,
    required Color onSecondary,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color surface,
    required Color onSurface,
    required Color appBarColor,
    required Color onAppBarColor,
    required Color error,
    required Color onError,
    required Color scaffoldBackground,
    required Color textColor,
    required Color mutedTextColor,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      surface: surface,
      onSurface: onSurface,
      error: error,
      onError: onError,
    );

    final fontFamily = GoogleFonts.spaceGrotesk().fontFamily;
    final textTheme = _textTheme(textColor, mutedTextColor);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: fontFamily,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: onAppBarColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleMedium?.copyWith(color: onAppBarColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: mutedTextColor.withValues(alpha: 0.2),
        thickness: 1,
      ),
    );
  }
}