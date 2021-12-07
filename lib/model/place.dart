import 'dart:io';

import 'package:get/get.dart';

class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longtitude,
    this.address,
  });
}

class Place  {

  final String id;
  final String title;
  PlaceLocation? location;
  final File image;
  
  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });

  

 
}
