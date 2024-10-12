import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_styles/my_colors.dart';

class AppThemeInfo {
  static double get borderRadius => 6.0;

  static ThemeData get themeData {

    const MaterialColor primaryColor = MaterialColor(
      0xFFD04679, // The primary color
      <int, Color>{
        50: Color(0xffffe5ee),  // Lightest shade
        100: Color(0xffffb3c8),
        200: Color(0xffff809e),
        300: Color(0xffff4d74),
        400: Color(0xffff2655),
        500: Color(0xffd04679),  // Main color
        600: Color(0xffb23e6b),
        700: Color(0xff95375e),
        800: Color(0xff782f51),
        900: Color(0xff5a253e),  // Darkest shade
      },
    );

    var baseTheme = ThemeData(
      useMaterial3: false, // Disabling Material 3
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeInfo.borderRadius),
        ),
        filled: false,
        fillColor: MyColors.fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              AppThemeInfo.borderRadius,
            ),
          ),
        ),
      ),
      cardTheme: const CardTheme(
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.lightBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.lightBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeInfo.borderRadius),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MyColors.accentColor,
        elevation: 2,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MyColors.lightBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          side: const BorderSide(color: MyColors.lightBlue),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: MyColors.lightBlue),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: MyColors.primary1Color,
        selectionHandleColor: MyColors.primary1Color,
        selectionColor: MyColors.primary1Color.withOpacity(0.5),
      ),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(fontSize: 16),
        unselectedLabelStyle: TextStyle(fontSize: 16),
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeInfo.borderRadius),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return MyColors.primary1Color;
              }
              return null;
            }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return MyColors.primary1Color;
              }
              return null;
            }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return MyColors.primary1Color;
              }
              return null;
            }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return MyColors.primary1Color;
              }
              return null;
            }),
      ),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primaryColor,
        accentColor: MyColors.accentColor,
        backgroundColor: Colors.white,
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
    );
  }
}
