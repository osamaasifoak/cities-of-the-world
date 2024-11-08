import 'package:cities_of_the_world/core/models/city_model.dart';
import 'package:cities_of_the_world/core/network/api_client.dart';

class CitiesApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<CityModel>> fetchCities() async {
    try {
      final response = await _apiClient.dio.get('/api/cities');
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => CityModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }
}
