import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:cities_of_the_world/providers/cities_provider.dart';
import 'package:cities_of_the_world/resources/resources.dart';
import 'package:cities_of_the_world/screens/cities_listview_screen.dart';
import 'package:cities_of_the_world/screens/cities_mapview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitiesView extends StatefulWidget {
  const CitiesView({super.key});

  @override
  State<CitiesView> createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.microtask(
        () => context.read<CitiesProvider>().fetchCities(page: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: AppStrings.listView,
              ),
              Tab(
                text: AppStrings.mapView,
              ),
            ],
          ),
        ),
        body: Consumer<CitiesProvider>(
          builder: (context, cityProvider, child) {
            switch (cityProvider.cities.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(child: Text(cityProvider.cities.message ?? ""));

              case Status.completed:
              default:
                return const TabBarView(
                  children: [
                    CitiesListviewScreen(),
                    CitiesMapviewScreen(),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
