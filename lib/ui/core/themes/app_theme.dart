import 'package:assets_challenge/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  final textTheme = Typography.blackMountainView;
  return ThemeData(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.midnightBlue,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.light(
      secondary: AppColors.brightBlue,
      onSecondary: Colors.white,
    ),
    chipTheme: ChipThemeData(
      labelPadding: EdgeInsets.all(8),
      showCheckmark: false,
      selectedColor: AppColors.brightBlue,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadiusGeometry.circular(4),
      ),
      labelStyle: textTheme.bodyMedium!.copyWith(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: Colors.grey.shade600,
      )
    ),
    searchBarTheme: SearchBarThemeData(
      constraints: BoxConstraints.tightFor(height: 48),
      textStyle: WidgetStateProperty.all(
        textTheme.bodyMedium!.copyWith(color: Colors.grey.shade600),
      ),
      backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      ),
      elevation: WidgetStateProperty.all(0.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide.none,
        ),
      ),
    ),
  );
}
