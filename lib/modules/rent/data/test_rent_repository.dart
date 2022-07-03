import 'package:dio/dio.dart';
import 'package:elki_app/modules/rent/domain/i_rent_repository.dart';

class TestRentRepository implements IRentRepository {
  final Dio _dio;

  TestRentRepository({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> fetchAvailableHouses() async {
    final response = await _dio.get('test/house.json');
    print(response.data);
  }
}
