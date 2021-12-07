import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemaps/controller/great_place_controller.dart';
import 'package:googlemaps/screens/add_place_screen.dart';
import 'package:googlemaps/screens/map_screen.dart';
import 'package:googlemaps/screens/place_details_screen.dart';

class PlaceListScreen extends StatelessWidget {
  static const screenName = '/placelist';
  @override
  Widget build(BuildContext context) {

    final GreatPlaceController greatplacexcontroller = Get.put(GreatPlaceController());

    return Scaffold(
        appBar: AppBar(
          title: Text('Your  Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(AddPlaceScreen.screenName);
                },
                icon: Icon(Icons.add)),
          ],
        ),
        body: FutureBuilder(
          
          future: greatplacexcontroller.fetchAndSetPlace(),
          builder: (ctx, snapshot)=>  snapshot.connectionState == ConnectionState.waiting? Center(child: CircularProgressIndicator(),) :  Obx(() => greatplacexcontroller.places.length <= 0
            ? Center(child: Text('No Place yet try adding some'))
            : ListView.builder(
                itemCount: greatplacexcontroller.places.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          FileImage(greatplacexcontroller.places[index].image),
                    ),
                    title: Text(greatplacexcontroller.places[index].title),
                    subtitle: Text(greatplacexcontroller.places[index].location!.address as String),
                    onTap: () {
                      Get.toNamed(PlaceDetailsScreen.screenName, arguments: greatplacexcontroller.places[index].id);
                    },
                  );
                })
                ) ,
        ) 
      
                );
  }
}
