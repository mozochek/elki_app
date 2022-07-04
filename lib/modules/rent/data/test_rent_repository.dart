import 'package:dio/dio.dart';
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:elki_app/modules/rent/domain/repository/i_rent_repository.dart';

class TestRentRepository implements IRentRepository {
  final Dio _dio;

  TestRentRepository({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<HouseInfoEntity>> fetchAvailableHouses() async {
    final response = await _dio.get<List>('test/house.json');

    return response.data!.map((e) => HouseInfoEntity.fromJson(e as Map<String, dynamic>)).toList();
  }
}
