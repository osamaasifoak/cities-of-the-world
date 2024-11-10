import 'package:cities_of_the_world/providers/cities_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitiesListviewScreen extends StatelessWidget {
  const CitiesListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesProvider>(
      builder: (context, consumer, child) {
        var cities = consumer.cities.body?.items;
        return RefreshIndicator(
          onRefresh: () => context.read<CitiesProvider>().fetchCities(page: 1),
          child: ListView.builder(
            itemCount: cities?.length,
            itemBuilder: (context, index) {
              final city = cities![index];
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city.name),
                subtitle: Text(city.country.name),
              );
            },
          ),
        );
      },
    );
  }
}
