import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/data/ProductModel.dart';

class MapScreen extends StatefulWidget {

   const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _permissionGranted = false; // Tracks the status of location permission.

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Requests location permission when the widget is initialized.
  }

  // Asynchronously requests location permission from the user.
  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status; // Checks the current permission status.
    if (!status.isGranted) {
      // If not granted, requests permission.
      status = await Permission.locationWhenInUse.request();
    }
    if (mounted) {
      // Checks if the widget is still part of the widget tree.
      setState(() {
        // Updates the state with the new permission status.
        _permissionGranted = status.isGranted;
      });
    }
  }

@override
Widget build(BuildContext context) {
  // Create the marker outside of the const set
  Marker castleMarker = const Marker(
    // Places a marker on the castle's location.
    markerId: MarkerId('shopMarker'),
    position: LatLng(23.6161,58.5978),
    infoWindow: InfoWindow(title: 'shop'), // Shows the castle's name.
  );

  return Scaffold(
    appBar: AppBar(
      title: const Text("Shop Location"), // Sets the app bar title.
    ),
    body: _permissionGranted
        ? GoogleMap(
      initialCameraPosition: const CameraPosition(
        // Centers the map on the castle's location.
        target:  LatLng(23.6161,58.5978),
        zoom: 5.0, // Sets the initial zoom level.
      ),
      markers: {
        castleMarker, // Add the marker to the set
      },
      myLocationEnabled: true, // Enables the 'My Location' button.
      myLocationButtonEnabled: true, // Shows the 'My Location' button if permission is granted.
    )
        : const Center(
      child: Text("Location permission is required to show the map."),
      // Displays a message if location permission is not granted.
    ),
  );
}
}