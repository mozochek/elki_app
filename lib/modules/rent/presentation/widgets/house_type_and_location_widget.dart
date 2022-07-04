import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:flutter/material.dart';

class HouseTypeAndLocationWidget extends StatelessWidget {
  final HouseType type;
  final String location;

  const HouseTypeAndLocationWidget({
    required this.type,
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final textTheme = appTheme.textTheme;
    final colorsScheme = appTheme.colorsScheme;

    return RichText(
      text: TextSpan(
        text: type.toL10n(context),
        style: textTheme.header.copyWith(
          color: colorsScheme.black,
        ),
        children: <InlineSpan>[
          const WidgetSpan(
            child: SizedBox(width: 4.0),
          ),
          TextSpan(
            text: location,
            style: textTheme.header.copyWith(
              color: colorsScheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
