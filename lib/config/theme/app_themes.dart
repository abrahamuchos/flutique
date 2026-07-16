import 'package:flutique/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'Lato',
    appBarTheme: appbarTheme(),
    primaryColor: AppColors.turkey
  );
}

AppBarTheme appbarTheme() {
  return AppBarTheme(
    color: AppColors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.dark),
    titleTextStyle: TextStyle(color: AppColors.dark, fontSize: 18),
  );
}
