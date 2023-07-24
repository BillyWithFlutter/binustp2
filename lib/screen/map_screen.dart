import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../user.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/google-maps';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String appBarTitle = '';

  @override
  void initState() {
    super.initState();
    fetchDataAndPopulateFields();
  }

  Future<void> fetchDataAndPopulateFields() async {
    Map<String, String> userData = await UserPreferences.fetchData();
    setState(() {
      appBarTitle = userData['name'] ??
          ''; // Update the AppBar title with a fallback value
    });
  }

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(-6.201659, 106.782327),
    zoom: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text(
                appBarTitle, // Replace this with your desired text
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: initialCameraPosition,
            ),
          ),
        ],
      ),
    );
  }
}
