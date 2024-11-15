import 'dart:convert';

import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:cities_of_the_world/providers/cities_provider.dart';
import 'package:cities_of_the_world/repositories/cities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCitiesRepository extends Mock implements CitiesRepository {}

Future<CitiesModel> _loadDummyCities() async {
  final jsonString = await rootBundle.loadString('test/dummy_cities.json');
  final jsonMap = json.decode(jsonString);
  return CitiesModel.fromJson(jsonMap["data"]);
}

void main() {
  late CitiesProvider citiesProvider;
  late MockCitiesRepository mockCitiesRepository;
  late CitiesModel cities;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    mockCitiesRepository = MockCitiesRepository();
    citiesProvider = CitiesProvider(citiesRepository: mockCitiesRepository);
    cities = await _loadDummyCities();
  });

  group('fetch cities', () {
    test('emits loading and then completed when fetchCities succeeds',
        () async {
      // Arrange
      when(() => mockCitiesRepository.getCitiesData(page: 1))
          .thenAnswer((_) async => DataState.completed(cities));

      // Act
      await citiesProvider.fetchCities(page: 1);

      // Assert
      expect(citiesProvider.cities, isA<DataState<CitiesModel>>());
      expect(citiesProvider.cities.status, DataState.completed(cities).status);
    });

    test('emits loading and then error when fetchCities failed', () async {
      const errorMessage = 'failed to fetch cities';
      // Arrange
      when(() => mockCitiesRepository.getCitiesData(page: 1))
          .thenAnswer((_) async => const DataState.error(errorMessage));

      // Act
      await citiesProvider.fetchCities(page: 1);

      // Assert
      expect(citiesProvider.cities, isA<DataState<CitiesModel>>());
      expect(citiesProvider.cities.status,
          const DataState.error(errorMessage).status);
    });
  });

  group('search cities', () {
    const searchQuery = 'Kabul';

    test('emit loading and then complete when searchCities succeeds', () async {
      // Arrange
      when(() => mockCitiesRepository.searchCities(query: searchQuery))
          .thenAnswer((_) async => DataState.completed(cities));
      // Act
      await citiesProvider.searchCities(query: searchQuery);

      // Assert
      expect(citiesProvider.searchResults, isA<DataState<CitiesModel>>());
      expect(citiesProvider.searchResults.status,
          DataState.completed(cities).status);
    });

    test('emit loading and then error when searchCities failed', () async {
      const searchError = 'failed to search cities';
      // Arrange
      when(() => mockCitiesRepository.searchCities(query: searchQuery))
          .thenAnswer((_) async => const DataState.error(searchError));
      // Act
      await citiesProvider.searchCities(query: searchQuery);

      // Assert
      expect(citiesProvider.searchResults, isA<DataState<CitiesModel>>());
      expect(citiesProvider.searchResults.status,
          const DataState.error(searchError).status);
    });
  });
}
