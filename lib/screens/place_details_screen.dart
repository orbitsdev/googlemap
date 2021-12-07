import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemaps/controller/great_place_controller.dart';
import 'package:googlemaps/model/place.dart';
import 'package:googlemaps/screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const screenName = '/placedetails';
  @override
  Widget build(BuildContext context) {

     var id = Get.arguments;
    var place = Get.find<GreatPlaceController>().finById(id);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              child: Image.file(place.image, fit: BoxFit.cover ),
            ),
            Text('${place.title}'),
            Text('${place.location!.address}'),
            Text('${place.location!.latitude}'),
            Text('${place.location!.longtitude}'),
            TextButton(onPressed: (){
              Get.toNamed(MapScreen.screenName, arguments: [place.location as PlaceLocation] );
            }, child: Text('View Map') )
          ],
        ),
      ), 
    );
  }
}
