import 'package:flutter/material.dart';

import 'custom_color.dart';
import 'custom_text_style.dart';

class ThemeConfig {
  static final ThemeData defaultTheme = ThemeData(
    fontFamily: "Poppins",
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: UniversalColor.green4,
      titleTextStyle: CustomTextStyle.gray1TextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: UniversalColor.green4,
      unselectedItemColor: UniversalColor.gray4,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: CustomTextStyle.green4TextStyle,
      unselectedLabelStyle: CustomTextStyle.gray4TextStyle,
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
  );
}
