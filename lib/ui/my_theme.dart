import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static const Color light_primary = Color(0xFF5D9CEC);
  static const Color lightScaffoldbackGround = Color(0xFFDFECDB);
  static const Color grey = Color(0xFFC8C9CB);
  static final LightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
            
        )

      )
    ),
      primaryColor: light_primary,
      scaffoldBackgroundColor: lightScaffoldbackGround,
      appBarTheme: AppBarTheme(color: light_primary, centerTitle: true),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(
            color: light_primary,
            size: 36,
          ),
          unselectedIconTheme: IconThemeData(color: grey, size: 36)));
}
