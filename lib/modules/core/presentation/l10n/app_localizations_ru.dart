

import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Ёлки';

  @override
  String get oFrame => 'O-frame';

  @override
  String get aFrame => 'A-frame';

  @override
  String get allHouses => 'Все дома';

  @override
  String get unknown => 'Неизвестный';

  @override
  String get failedToGetImage => 'Не удалось получить изображение';

  @override
  String get noImages => 'Нет изображений';

  @override
  String get descriptionIsMissing => 'Описание отсутствует';

  @override
  String get dayAbbr => 'сут.';

  @override
  String get back => 'Назад';

  @override
  String reviewsPlural(num amount) {
    return intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      one: '$amount отзыв',
      few: '$amount отзыва',
      other: '$amount отзывов',
    );
  }
}
