import 'package:flutter/material.dart';
import 'package:holo_products_app/constants/my_colors.dart';
//
// ThemeData lightMode = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(
//     surface: MyColors.white,
//     primary: MyColors.black,
//   )
// );
//
// ThemeData darkMode = ThemeData(
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.light(
//         surface: MyColors.grey900,
//       primary: MyColors.white,
//     )
// );


class AppTheme {
  static ThemeData getTheme (bool isDark) {
      return ThemeData (
      useMaterial3: false,
        colorScheme: ColorScheme (
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: isDark ? MyColors.grey900 : MyColors.white,
          onPrimary: isDark ? MyColors.white : MyColors.grey900,
          secondary: isDark ? MyColors.grey900 : MyColors.grey900,
          onSecondary: isDark ? MyColors.white : MyColors.grey900,
          error: Colors.red, onError: Colors.white,
          surface: isDark ? MyColors.grey900 : MyColors.white,
          onSurface: isDark ? MyColors.white :MyColors.grey300,
        ),
      );
 }
}