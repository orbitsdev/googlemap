import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/hellper/location_helper.dart';
import 'package:googlemaps/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

final Function selectplace;
LocationInput({required this.selectplace});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _priviewLocation;
  var locationData;

  Future<void> _getCurrentLocation() async {
    locationData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreview(
        locationData.latitude as double, locationData.longitude as double);
    setState(() {
      _priviewLocation = staticMapImageUrl;
    });
    widget.selectplace(locationData.latitude as double, locationData.longitude as double);
  }

  Future<void> _selectOnMap() async {
    var data = await Get.toNamed(MapScreen.screenName, arguments: [null]);

    if (data != null) {
      final staticMapImageUrl = LocationHelper.generateLocationPreview(
          data.latitude as double, data.longtitude as double);

      setState(() {
        _priviewLocation = staticMapImageUrl;
      });
     
    widget.selectplace(data.latitude, data.longtitude);
  }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 170,
          alignment: Alignment.center,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _priviewLocation == null
              ? Text(
                  'No Location Added Yet ',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _priviewLocation as String,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),
            TextButton.icon(
                onPressed: () {
                  _selectOnMap();
                },
                icon: Icon(Icons.map),
                label: Text('Select Location')),
          ],
        )
      ],
    );
  }
}
