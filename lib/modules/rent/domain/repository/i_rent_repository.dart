import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';

abstract class IRentRepository {
  Future<List<HouseInfoEntity>> fetchAvailableHouses();
}
