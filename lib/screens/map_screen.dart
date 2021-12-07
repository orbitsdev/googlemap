import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/controller/great_place_controller.dart';
import 'package:googlemaps/model/place.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const screenName = '/map';
  
  

  bool isSelecting = false;
  bool ispassData= false;
  
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  

   var placelocation; 
  @override
  void initState() {
    super.initState();
    setmapLocation();
  }

  Future<void> setmapLocation() async {
    var passlocation = Get.arguments[0];
    var currentlocation;

    if (passlocation == null) {
      print('did not pass ____________');
      currentlocation = await Location().getLocation();
      setState(() {
        placelocation = LatLng(currentlocation.latitude as double,
            currentlocation.longitude as double);
      });
    } else {
      print(' pass data ____________');
      print(passlocation.latitude);
      print(passlocation.longtitude);
      setState(() {
        widget.ispassData = true;
        placelocation =
            LatLng(passlocation.latitude, passlocation.longtitude);
      });
    }
  }

  void selectedLocation(LatLng position) {
    setState(() {
      widget.isSelecting = true;
      placelocation = position as LatLng;
    });
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {
              Get.back(result: PlaceLocation(latitude: placelocation.latitude , longtitude: placelocation.longitude));
            }, icon: Icon(Icons.check))
        ],
      ),
      body:placelocation!= null ?  GoogleMap(
        initialCameraPosition: CameraPosition(
          target: placelocation,
          zoom: 16,
        ),
        markers: ( widget.isSelecting == false && widget.ispassData ==false ) 
            ? {}
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position: placelocation as LatLng ),
              },
        onTap: widget.ispassData ? null : selectedLocation,
      ): Container(),
    );
  }
}
