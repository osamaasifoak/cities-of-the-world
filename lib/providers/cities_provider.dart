import 'package:flutter/material.dart';
import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/repositories/cities_repository.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';

class CitiesProvider extends ChangeNotifier {
  final CitiesRepository _cityRepository = CitiesRepository();
  DataState<CitiesModel> cities = const DataState.loading();
  DataState<CitiesModel> searchResults = const DataState.completed(null);
  String searchQuery = '';

  Future<void> fetchCities({required int page, bool isLoading = true}) async {
    if (isLoading) {
      cities = const DataState.loading();
      notifyListeners();
    }

    final response = await _cityRepository.getCitiesData(page: page);
    if (cities.body != null && cities.body!.items.isNotEmpty) {
      final updatedCities = cities.body!.copyWith(
        items: [...cities.body!.items, ...response.body!.items],
        pagination: response.body?.pagination,
      );
      cities = DataState.completed(updatedCities);
    } else {
      cities = response;
    }

    notifyListeners();
  }

  Future<void> searchCities({required String query}) async {
    searchQuery = query;
    if (query.isEmpty) {
      searchResults = const DataState.completed(null);
      notifyListeners();
      return;
    }

    searchResults = const DataState.loading();
    notifyListeners();

    searchResults = await _cityRepository.searchCities(query: query);

    notifyListeners();
  }
}
