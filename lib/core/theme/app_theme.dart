import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBackground,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        surface: kSurface,
        primary: kBlue,
        error: kRed,
        onSurface: kTextPrimary,
        onPrimary: kTextPrimary,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: kSurface,
        foregroundColor: kTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: kSubheading,
        iconTheme: const IconThemeData(color: kTextPrimary),
        actionsIconTheme: const IconThemeData(color: kTextPrimary),
      ),

      // Icons
      iconTheme: const IconThemeData(
        color: kTextPrimary,
        size: 24,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: kSurface,
        selectedItemColor: kTextPrimary,
        unselectedItemColor: kTextSecondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Divider
      dividerColor: kDivider,
      dividerTheme: const DividerThemeData(
        color: kDivider,
        thickness: 0.5,
        space: 0,
      ),

      // Removes ink splash / highlight effects for clean taps
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,

      // Text theme using Inter
      textTheme: TextTheme(
        headlineMedium: kHeading,
        titleLarge: kSubheading,
        titleMedium: kBodyBold,
        bodyLarge: kBody,
        bodyMedium: kCaption,
        labelLarge: kCaptionBold,
        bodySmall: kSmall,
        labelSmall: kTiny,
      ).apply(
        fontFamily: GoogleFonts.inter().fontFamily,
        bodyColor: kTextPrimary,
        displayColor: kTextPrimary,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kSurface,
        hintStyle: kBody.copyWith(color: kTextSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kTextSecondary),
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlue,
          foregroundColor: kTextPrimary,
          textStyle: kBodyBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kBlue,
          textStyle: kBodyBold,
        ),
      ),

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
