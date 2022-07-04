import 'package:elki_app/modules/core/presentation/l10n/app_localizations.dart';
import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HouseRentPriceWidget extends StatelessWidget {
  final int price;

  const HouseRentPriceWidget({
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final textTheme = appTheme.textTheme;
    final textColor = appTheme.colorsScheme.black;

    return RichText(
      text: TextSpan(
        text: '$price ₽',
        style: textTheme.header.copyWith(
          color: textColor,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: '/${AppLocalizations.of(context).dayAbbr}',
            style: textTheme.commonText.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
