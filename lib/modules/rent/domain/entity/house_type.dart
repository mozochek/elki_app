import 'package:elki_app/modules/core/presentation/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum HouseType {
  oFrame,
  aFrame,
  unknown;

  static HouseType deserialize(String value) {
    switch (value) {
      case 'o-frame':
        return HouseType.oFrame;
      case 'a-frame':
        return HouseType.aFrame;
      default:
        return HouseType.unknown;
    }
  }

  String toL10n(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (this) {
      case HouseType.oFrame:
        return l10n.oFrame;
      case HouseType.aFrame:
        return l10n.aFrame;
      case HouseType.unknown:
        return l10n.unknown;
    }
  }
}
