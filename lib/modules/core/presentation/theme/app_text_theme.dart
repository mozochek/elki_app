import 'package:elki_app/modules/core/presentation/constants/app_text_styles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppTextTheme with EquatableMixin {
  final TextStyle header;
  final TextStyle commonText;
  final TextStyle smallText;

  const AppTextTheme({
    required this.header,
    required this.commonText,
    required this.smallText,
  });

  @override
  List<Object?> get props => [header, commonText, smallText];
}

class DefaultAppTextTheme extends AppTextTheme {
  const DefaultAppTextTheme()
      : super(
          header: AppTextStyles.header,
          commonText: AppTextStyles.commonText,
          smallText: AppTextStyles.smallText,
        );
}
