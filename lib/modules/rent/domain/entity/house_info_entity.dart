import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_info_entity.freezed.dart';

@freezed
class HouseInfoEntity with _$HouseInfoEntity {
  const HouseInfoEntity._();

  const factory HouseInfoEntity({
    required String id,
    required String name,
    required String location,
    required String description,
    required HouseType type,
    required int rating,
    required int reviewsCount,
    required List<String> imageUrls,
    required int dailyPrice,
  }) = _HouseInfoEntity;

  factory HouseInfoEntity.fromJson(Map<String, dynamic> json) {
    // здесь не используется arrow syntax для того, чтобы freezed не генерировал код для парсинга модели из json
    return HouseInfoEntity(
      id: '${json['id'] as int}',
      name: json['name'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      type: HouseType.deserialize(json['type'] as String),
      rating: json['rating'] as int,
      reviewsCount: json['review_count'] as int,
      imageUrls: (json['images'] as List).map((e) => e as String).toList(),
      dailyPrice: json['price'] as int,
    );
  }

  bool get haveImages => imageUrls.isNotEmpty;

  String? get previewImage => haveImages ? imageUrls.first : null;
}
