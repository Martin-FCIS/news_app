import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.lightBg,
      primaryColorLight: AppColors.darkBg,
      scaffoldBackgroundColor: AppColors.lightBg,
      textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 18,color: AppColors.darkBg),
          bodyLarge: TextStyle(fontSize: 25,color: AppColors.darkBg),
          bodyMedium: TextStyle(fontSize: 20,color: AppColors.darkBg)),
      appBarTheme: AppBarTheme(
          color: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 30)));
  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.darkBg,
      primaryColorLight: AppColors.lightBg,
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 18,color: AppColors.lightBg),
            bodyLarge: TextStyle(fontSize: 25,color: AppColors.lightBg),
            bodyMedium: TextStyle(fontSize: 20,color: AppColors.lightBg),
      ),

      appBarTheme: AppBarTheme(
          color: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30)));
}
