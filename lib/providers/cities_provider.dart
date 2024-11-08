import 'package:flutter/material.dart';
import 'package:cities_of_the_world/core/models/city_model.dart';
import 'package:cities_of_the_world/repositories/cities_repository.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';

class CitiesProvider extends ChangeNotifier {
  DataState<List<CityModel>> cities = const DataState.loading();
  final CitiesRepository _cityRepository = CitiesRepository();

  Future<void> fetchCities() async {
    cities = const DataState.loading();
    notifyListeners();

    final response = await _cityRepository.getCitiesData();

    cities = response;
    notifyListeners();
  }
}
