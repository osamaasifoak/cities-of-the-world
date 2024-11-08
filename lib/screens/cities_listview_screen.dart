import 'package:flutter/material.dart';

class CitiesListviewScreen extends StatelessWidget {
  const CitiesListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.location_city),
          title: Text('City Name $index'),
          subtitle: const Text('Country Name'),
        );
      },
    );
  }
}
