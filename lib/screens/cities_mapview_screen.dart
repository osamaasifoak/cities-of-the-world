import 'dart:async';
import 'package:cities_of_the_world/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cities_of_the_world/core/utils/data_state.dart';
import 'package:cities_of_the_world/providers/cities_provider.dart';

class CitiesMapviewScreen extends StatefulWidget {
  const CitiesMapviewScreen({super.key});

  @override
  State<CitiesMapviewScreen> createState() => _CitiesMapviewScreenState();
}

class _CitiesMapviewScreenState extends State<CitiesMapviewScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesProvider>(
      builder: (context, provider, child) {
        final cities = provider.searchQuery.isEmpty
            ? provider.cities.body?.items
            : provider.searchResults.body?.items;

        if (provider.searchResults.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (cities == null || cities.isEmpty) {
          return const Center(
            child: Text(AppStrings.noCitiesFound),
          );
        }

        Set<Marker> markers = {};
        for (var city in cities) {
          if (city.lat != null && city.lng != null) {
            markers.add(
              Marker(
                markerId: MarkerId(
                  city.name,
                ),
                position: LatLng(city.lat!, city.lng!),
                infoWindow: InfoWindow(title: city.name),
              ),
            );
          }
        }

        return GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(cities.first.lat ?? 0.0, cities.first.lng ?? 0.0),
            zoom: 2,
          ),
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
        );
      },
    );
  }
}
