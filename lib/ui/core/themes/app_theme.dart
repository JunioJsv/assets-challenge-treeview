import 'package:assets_challenge/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.midnightBlue,
    foregroundColor: Colors.white,
    centerTitle: true,
  ),
  colorScheme: ColorScheme.light(
    secondary: AppColors.brightBlue,
    onSecondary: Colors.white,
  ),
);