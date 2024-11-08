import 'package:cities_of_the_world/resources/resources.dart';
import 'package:cities_of_the_world/screens/cities_listview_screen.dart';
import 'package:cities_of_the_world/screens/cities_mapview_screen.dart';
import 'package:flutter/material.dart';

class CitiesView extends StatelessWidget {
  const CitiesView({super.key});

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
        body: const TabBarView(
          children: [
            CitiesListviewScreen(),
            CitiesMapviewScreen(),
          ],
        ),
      ),
    );
  }
}
