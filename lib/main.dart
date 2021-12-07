import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:googlemaps/screens/add_place_screen.dart';
import 'package:googlemaps/screens/map_screen.dart';
import 'package:googlemaps/screens/place_details_screen.dart';
import 'package:googlemaps/screens/place_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.amber),
      ),
      home: PlaceListScreen(),
      getPages: [
        GetPage(name: PlaceListScreen.screenName, page: () => PlaceListScreen()),
        GetPage(name: AddPlaceScreen.screenName, page: () => AddPlaceScreen()),
        GetPage(name: PlaceDetailsScreen.screenName, page: () => PlaceDetailsScreen()),
        GetPage(name: MapScreen.screenName, page: () => MapScreen()),
      ],
      
      debugShowCheckedModeBanner: false,
    );
  }
}
