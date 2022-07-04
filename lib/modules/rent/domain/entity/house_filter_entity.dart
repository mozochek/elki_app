import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_filter_entity.freezed.dart';

@freezed
class HouseFilterEntity with _$HouseFilterEntity {
  const HouseFilterEntity._();

  const factory HouseFilterEntity({
    /// Если значение [type] равно null, это означает что должны отображаться дома с любым типом.
    HouseType? type,
  }) = _HouseFilterEntity;
}
