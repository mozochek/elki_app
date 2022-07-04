import 'package:elki_app/modules/core/presentation/constants/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppColorsScheme with EquatableMixin {
  final Color black;
  final Color white;
  final Color lightGrey;
  final Color grey;
  final Color beige;
  final Color primary;

  const AppColorsScheme({
    required this.black,
    required this.white,
    required this.lightGrey,
    required this.grey,
    required this.beige,
    required this.primary,
  });

  @override
  List<Object?> get props => [black, white, lightGrey, grey, beige, primary];
}

class LightAppColorsScheme extends AppColorsScheme {
  const LightAppColorsScheme()
      : super(
          black: AppColors.black,
          white: AppColors.white,
          lightGrey: AppColors.lightGrey,
          grey: AppColors.grey,
          beige: AppColors.beige,
          primary: AppColors.primary,
        );
}
