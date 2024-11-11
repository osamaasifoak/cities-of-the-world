import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:provider/provider.dart';
import 'package:cities_of_the_world/providers/cities_provider.dart';
import 'package:flutter/material.dart';

class CitiesListviewScreen extends StatefulWidget {
  const CitiesListviewScreen({super.key});

  @override
  State<CitiesListviewScreen> createState() => _CitiesListviewScreenState();
}

class _CitiesListviewScreenState extends State<CitiesListviewScreen> {
  @override
  Widget build(BuildContext context) {
    final citiesProvider = context.read<CitiesProvider>();

    return Consumer<CitiesProvider>(
      builder: (context, provider, child) {
        final cities = provider.searchQuery.isEmpty
            ? provider.cities.body?.items
            : provider.searchResults.body?.items;

        final pagination = provider.cities.body?.pagination;

        if (provider.searchResults.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (cities == null || cities.isEmpty) {
          return const Center(child: Text("No cities found"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            final metrics = scrollInfo.metrics;
            if (pagination != null) {
              bool hasMore = pagination.currentPage < pagination.lastPage;
              if (hasMore && metrics.pixels == metrics.maxScrollExtent) {
                int nextPage = pagination.currentPage + 1;
                citiesProvider.fetchCities(page: nextPage, isLoading: false);
                return hasMore;
              }
            }

            return false;
          },
          child: RefreshIndicator(
            onRefresh: () => citiesProvider.fetchCities(page: 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(city.name),
                        subtitle: Text(city.country.name),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
