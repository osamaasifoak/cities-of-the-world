// ignore_for_file: use_build_context_synchronously

import 'dart:async';

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
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _searchController.addListener(_onSearchChanged);
      Future.microtask(
        () => context.read<CitiesProvider>().fetchCities(page: 1),
      );
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () {
        var citiesProvider = context.read<CitiesProvider>();
        citiesProvider.searchCities(query: _searchController.text).then(
          (_) {
            if (citiesProvider.searchResults.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    citiesProvider.searchResults.message ??
                        AppStrings.somethingWentWrong,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        );
      },
    );
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
          builder: (context, citiesProvider, child) {
            switch (citiesProvider.cities.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(child: Text(citiesProvider.cities.message ?? ""));

              case Status.completed:
              default:
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: AppStrings.searchCity,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CitiesListviewScreen(),
                          CitiesMapviewScreen(),
                        ],
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
