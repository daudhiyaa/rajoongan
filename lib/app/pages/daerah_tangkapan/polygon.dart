// https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/maps/tile_layer/vector_layer/polylines.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:syncfusion_flutter_maps/maps.dart';

import 'sample_view.dart';

class MapPolygonPage extends SampleView {
  const MapPolygonPage({Key? key}) : super(key: key);

  @override
  _MapPolygonPageState createState() => _MapPolygonPageState();
}

class _MapPolygonPageState extends SampleViewState {
  late MapZoomPanBehavior _zoomPanBehavior;
  late String _boundaryJson;

  Future<Set<MapPolygon>> _getPolygonPoints() async {
    List<dynamic> polygonGeometryData;
    int multipolygonGeometryLength;
    final List<List<MapLatLng>> polygons = <List<MapLatLng>>[];
    final String data = await rootBundle.loadString(_boundaryJson);
    final dynamic jsonData = json.decode(data);
    const String key = 'features';
    final int jsonLength = jsonData[key].length as int;
    print('jsonlengt $jsonLength');
    for (int i = 0; i < jsonLength; i++) {
      final dynamic features = jsonData[key][i];
      final Map<String, dynamic> geometry =
          features['geometry'] as Map<String, dynamic>;

      if (geometry['type'] == 'Polygon') {
        polygonGeometryData = geometry['coordinates'] as List<dynamic>;
        polygons.add(_getLatLngPoints(polygonGeometryData));
      } else {
        multipolygonGeometryLength = geometry['coordinates'].length as int;
        for (int j = 0; j < multipolygonGeometryLength; j++) {
          polygonGeometryData = geometry['coordinates'][j][0] as List<dynamic>;
          polygons.add(_getLatLngPoints(polygonGeometryData));
        }
      }
    }
    return _getPolygons(polygons);
  }

  List<MapLatLng> _getLatLngPoints(List<dynamic> polygonPoints) {
    final List<MapLatLng> polygon = <MapLatLng>[];
    for (int i = 0; i < polygonPoints.length; i++) {
      polygon.add(MapLatLng(polygonPoints[i][1], polygonPoints[i][0]));
    }
    return polygon;
  }

  Set<MapPolygon> _getPolygons(List<List<MapLatLng>> polygonPoints) {
    return List<MapPolygon>.generate(
      polygonPoints.length,
      (int index) {
        return MapPolygon(points: polygonPoints[index]);
      },
    ).toSet();
  }

  MapSublayer _getPolygonLayer(Set<MapPolygon> polygons) {
    return MapPolygonLayer(
      polygons: polygons,
      color: Colors.grey.withOpacity(0.5),
      strokeColor: Colors.red,
    );
  }

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 8.5,
      // Brazil coordinate.
      // focalLatLng: const MapLatLng(-14.2350, -51.9253),
      // Madura coordinate.
      focalLatLng: const MapLatLng(-6.4673208, 113.3824768),
      minZoomLevel: 3,
      maxZoomLevel: 15,
      enableDoubleTapZooming: true,
    );
    _boundaryJson = 'assets/json/batimetri_dipakai.json';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _getPolygonPoints(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/shape_map/maps_grid.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              MapTileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                sublayers: <MapSublayer>[_getPolygonLayer(snapshot.data)],
                zoomPanBehavior: _zoomPanBehavior,
              ),
            ],
          );
        } else {
          // Showing empty container when the snapshot data is empty.
          return Container();
        }
      },
    );
  }
}

class PolygonDataModel {
  PolygonDataModel(this.name, this.imagePath, {required this.color});

  final String name;
  final String imagePath;
  final Color color;
}
