import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/core/network/api_client.dart';

class CitiesApiService {
  final ApiClient _apiClient = ApiClient();

  Future<CitiesModel> fetchCities({required int page}) async {
    try {
      String endPoint = "/square1/connect/v1/city?page=$page&include=country";
      final response = await _apiClient.dio.get(
        endPoint,
      );

      return CitiesModel.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception('Failed to load cities');
    }
  }

  Future<CitiesModel> searchCities({required String query}) async {
    final response = await _apiClient.dio.get(
        '/square1/connect/v1/city?filter[0][name][contains]=$query&include=country');

    if (response.statusCode == 200) {
      return CitiesModel.fromJson(response.data["data"]);
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
