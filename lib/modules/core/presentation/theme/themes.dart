import 'package:elki_app/modules/core/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

abstract class Themes {
  const Themes._();

  static ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightGrey,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.light(
      secondary: AppColors.primary,
    ),
  );
}