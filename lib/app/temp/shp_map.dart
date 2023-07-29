import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter_map/flutter_map.dart';

class ShapefileMap extends StatefulWidget {
  const ShapefileMap({super.key});

  @override
  State<ShapefileMap> createState() => _ShapefileMapState();
}

class _ShapefileMapState extends State<ShapefileMap> {
  late MapShapeSource _dataSource;

  @override
  void initState() {
    _dataSource = const MapShapeSource.asset(
      'assets/Batimetri.json',
      shapeDataField: 'STATE_NAME',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfMaps(
          layers: [
            // MapTileLayer(
            //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //   initialFocalLatLng: MapLatLng(-20, 147),
            //   initialZoomLevel: 3,
            // ),
            MapShapeLayer(
              source: _dataSource,
              loadingBuilder: (BuildContext context) {
                return Container(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
