import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? color;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets textPadding;

  const RoundedButton({
    required this.text,
    required this.onTap,
    this.textStyle,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(47.0)),
    this.textPadding = const EdgeInsets.symmetric(vertical: 15.0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final colorsScheme = appTheme.colorsScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? colorsScheme.primary,
          borderRadius: borderRadius,
        ),
        padding: textPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: textStyle ??
                  appTheme.textTheme.header.copyWith(
                    color: colorsScheme.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
