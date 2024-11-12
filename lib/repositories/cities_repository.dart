import 'package:hive_flutter/hive_flutter.dart';
import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:cities_of_the_world/services/cities_api_services.dart';

class CitiesRepository {
  final CitiesApiService _cityApiService = CitiesApiService();

  Future<DataState<CitiesModel>> getCitiesData({required int page}) async {
    var box = await Hive.openBox('cacheBox');
    final cacheKey = 'cityData_$page';

    if (box.containsKey(cacheKey)) {
      final cachedData = box.get(cacheKey);
      if (cachedData != null) {
        return DataState.completed(cachedData);
      }

      return const DataState.completed(null);
    } else {
      try {
        final CitiesModel cities =
            await _cityApiService.fetchCities(page: page);
        await box.put(cacheKey, cities);

        return DataState.completed(cities);
      } catch (e) {
        return DataState.error(e.toString());
      }
    }
  }

  Future<DataState<CitiesModel>> searchCities({required String query}) async {
    var box = await Hive.openBox('cacheBox');
    final cacheKey = 'search_$query';

    if (box.containsKey(cacheKey)) {
      return DataState.completed(box.get(cacheKey));
    }

    try {
      final cities = await _cityApiService.searchCities(query: query);

      await box.put(cacheKey, cities);
      return DataState.completed(cities);
    } catch (e) {
      return DataState.error(e.toString());
    }
  }
}
