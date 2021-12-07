import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemaps/hellper/db_hepler.dart';
import 'package:googlemaps/hellper/location_helper.dart';
import 'package:googlemaps/model/place.dart';
import 'dart:convert';

import 'package:location/location.dart';

class GreatPlaceController extends GetxController {
  var places = <Place>[].obs;
  var initiallocation = PlaceLocation(latitude:  6.63224, longtitude: 124.6002184).obs;

  

  

  Future<void> addPlace(String title, File pickedImage, PlaceLocation pickedlocation) async {

      final address = await LocationHelper.getPlaceAddress(pickedlocation.latitude, pickedlocation.longtitude);
      final updatedLocation = PlaceLocation(latitude: pickedlocation.latitude, longtitude: pickedlocation.longtitude, address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: updatedLocation,
    );

    places.add(newPlace);

    DBHelper.insert('user_place', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longtitude,
      'address': newPlace.location!.address as String,

    });
  }

  Future<void> fetchAndSetPlace() async {
    final datalist = await DBHelper.getdata('user_place');
    places = datalist
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(latitude: item['loc_lat'], longtitude: item['loc_lng'], address: item['address'])))
        .toList()
        .obs;
  }


  Place finById(String id) {
    var selectplace =  places.indexWhere((place) => place.id == id );
    return places[selectplace];
  }



}
