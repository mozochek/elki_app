import 'package:flutter/painting.dart';

abstract class AppTextStyles {
  const AppTextStyles._();

  static const TextStyle header = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 19.0,
  );

  static const TextStyle commonText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );

  static const TextStyle smallText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10.0,
  );
}
