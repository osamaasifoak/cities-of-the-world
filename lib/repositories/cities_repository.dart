import 'package:cities_of_the_world/core/models/city_model.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:cities_of_the_world/services/cities_api_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CitiesRepository {
  final CitiesApiService _cityApiService = CitiesApiService();

  Future<DataState<List<CityModel>>> getCitiesData() async {
    var box = await Hive.openBox('cacheBox');

    if (box.containsKey('cityData')) {
      final List<dynamic> cachedData = box.get('cityData');
      final parsedData =
          cachedData.map((json) => CityModel.fromJson(json)).toList();
      return DataState.completed(parsedData);
    } else {
      try {
        final List<CityModel> cities = await _cityApiService.fetchCities();
        await box.put('cityData', cities.map((city) => city.toJson()).toList());
        return DataState.completed(cities);
      } catch (e) {
        return DataState.error('Failed to fetch city data: $e');
      }
    }
  }
}
