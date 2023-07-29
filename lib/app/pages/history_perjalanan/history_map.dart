import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';

class MapHistoryTravel extends StatefulWidget {
  List<dynamic> listLatLng;
  MapHistoryTravel({super.key, required this.listLatLng});

  @override
  State<MapHistoryTravel> createState() => _MapHistoryTravelState();
}

class _MapHistoryTravelState extends State<MapHistoryTravel> {
  List<Marker> listMarkers = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.listLatLng.length; i++) {
      listMarkers.add(
        Marker(
          markerId: MarkerId('$i'),
          position: LatLng(widget.listLatLng[i][0], widget.listLatLng[i][1]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(listMarkers);
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.listLatLng[2][0], widget.listLatLng[2][1]),
            zoom: 18,
          ),
          markers: Set<Marker>.of(listMarkers),
        ),
        const BackButtonOnMap(),
      ],
    );
  }
}
