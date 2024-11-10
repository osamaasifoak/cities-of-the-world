import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/core/network/api_client.dart';

class CitiesApiService {
  final ApiClient _apiClient = ApiClient();

  Future<CitiesModel> fetchCities({required int page}) async {
    try {
      String endPoint = "/square1/connect/v1/city?page=$page&include=country";
      final response = await _apiClient.dio.get(endPoint);

      return CitiesModel.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }
}
