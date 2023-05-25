import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: "JA",
      iconTheme: const IconThemeData(color: AppColors.background),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      splashColor: AppColors.splash,
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(AppColors.primary),
          overlayColor: MaterialStateProperty.all(AppColors.font)),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(AppColors.splash),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.font,
            displayColor: AppColors.font, fontFamily: "JA",
            // fontSizeFactor: 1.05,
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondry,
            textStyle: const TextStyle(color: AppColors.background),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.font,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.primary,
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondry,
        background: AppColors.background,
      ).copyWith(background: AppColors.background),
    );
  }
}
