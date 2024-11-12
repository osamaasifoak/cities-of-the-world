import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cities_of_the_world/core/models/country_model.dart';
import 'package:cities_of_the_world/core/models/pagination_model.dart';
import 'package:cities_of_the_world/core/models/cities_model.dart';
import 'package:cities_of_the_world/core/models/city_model.dart';
import 'package:cities_of_the_world/providers/cities_provider.dart';
import 'package:cities_of_the_world/resources/resources.dart';
import 'package:cities_of_the_world/screens/cities_screen.dart';

void main() async {
  await Hive.initFlutter();
  setGoogleMapKeyIOS();
  _registerHiveAdapters();
  runApp(const MyApp());
}

void _registerHiveAdapters() {
  Hive.registerAdapter(CitiesModelAdapter());
  Hive.registerAdapter(CityModelAdapter());
  Hive.registerAdapter(CountryModelAdapter());
  Hive.registerAdapter(PaginationModelAdapter());
}

void setGoogleMapKeyIOS() {
  const platform = MethodChannel("com.example.citiesOfTheWorld/key");

  platform.invokeMethod(
      "setGoogleMapKey", const String.fromEnvironment("GOOGLE_MAP_KEY"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CitiesProvider>(create: (_) => CitiesProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CitiesView(),
      ),
    );
  }
}
