import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemaps/controller/great_place_controller.dart';
import 'package:googlemaps/model/place.dart';
import 'package:googlemaps/widgets/image_input.dart';
import 'package:googlemaps/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const screenName = '/addplace';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final greatplaceXcontroller = Get.find<GreatPlaceController>();

  final titlecontroller = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedlocation;
  

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (titlecontroller.text.isEmpty || _pickedImage == null || _pickedlocation == null)  {
      return;
    }

    
    greatplaceXcontroller.addPlace(titlecontroller.text, _pickedImage as File, _pickedlocation as PlaceLocation);
    Get.back();
  }

  void _selectPlace(double latitude, double longtitude){
    
    setState(() {
   _pickedlocation = PlaceLocation(latitude: latitude, longtitude: longtitude );
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titlecontroller,
                    ),
                    ImageInput(onSelectImage: _selectedImage),
                  ],
                ),
              ),
              LocationInput(selectplace: _selectPlace, ),
              ElevatedButton.icon(
                  onPressed: () {
                    _savePlace();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Place')),
            ],
          ),
        ),
      ),
    );
  }
}
