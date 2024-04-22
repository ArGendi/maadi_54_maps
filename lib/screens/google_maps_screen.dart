// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  bool normal = true;
  late GoogleMapController mapController;

  void persmission() async{
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    persmission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onCameraMove: (position) {
              print("position -----> ${position.target}");
            },
            onMapCreated: (controller) {
              mapController = controller;
            },
            mapType: normal == true ? MapType.normal : MapType.satellite,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.0444, 31.2357),
              zoom: 16,
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 25,
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      normal = !normal;
                    });
                  }, 
                  icon: Icon(Icons.swap_horiz),
                ), 
              ),
            ),
          ),
          
          Center(
            child: Opacity(
              opacity: 0.4,
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Icon(Icons.location_on, size: 50, color: Colors.red,),
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(31.2001, 29.9187), zoom: 10)
          ));
        },
        child: Icon(Icons.airplanemode_active),
      ),
    );
  }
}