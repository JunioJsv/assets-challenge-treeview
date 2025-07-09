import 'package:assets_challenge/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.midnightBlue,
    centerTitle: true,
  ),
  colorScheme: ColorScheme.light(
    secondary: AppColors.brightBlue
  )
);