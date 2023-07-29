// https://protocoderspoint.com/flutter-get-current-location-address-from-latitude-longitude/
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';
import 'package:rajoongan/app/components/container/container_in_map.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/constants/polygon_points.dart';

class MapPage extends StatefulWidget {
  final double ltNow, lngNow;
  final double kecepatanDinas, horsePower;
  const MapPage({
    Key? key,
    this.ltNow = 0,
    this.lngNow = 0,
    this.kecepatanDinas = 10,
    this.horsePower = 20,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  double finalDistance = 0, liter = 0, hr = 0, mn = 0, sc = 0;
  List<Marker> listMarker = [
    const Marker(
      markerId: MarkerId('src'),
      position: LatLng(37.33500926, -122.03272188),
    ),
    const Marker(
      markerId: MarkerId('dest'),
      position: LatLng(37.33429383, -122.06600055),
    ),
  ];

  void setMarkerNow(double? ltNow, double? lngNow) {
    listMarker[0] = Marker(
      markerId: const MarkerId('markerNow'),
      position: LatLng(ltNow!, lngNow!),
    );
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    finalDistance = distance;
  }

  void calculateTravelingTime(double dist, double vel) {
    double velInKph = vel * 1.852;
    double velocityInSec = velInKph * (1 / 3600);
    double timeInSeconds = dist / velocityInSec;

    hr = timeInSeconds / 3600;
    mn = (timeInSeconds % 3600) / 60;
    sc = timeInSeconds % 60;
  }

  void calculateLiterBBM() {
    liter = 0.16 * widget.horsePower * hr;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    double? ltNow = widget.ltNow;
    double? lngNow = widget.lngNow;
    setMarkerNow(ltNow, lngNow);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(ltNow, lngNow),
              zoom: 15.5,
            ),
            onTap: (LatLng latLng) {
              listMarker[1] = Marker(
                markerId: const MarkerId('mark'),
                position: latLng,
              );
              calculateDistance(
                listMarker[0].position.latitude,
                listMarker[0].position.longitude,
                listMarker[1].position.latitude,
                listMarker[1].position.longitude,
              );
              calculateTravelingTime(finalDistance, widget.kecepatanDinas);
              calculateLiterBBM();
              setState(() {});
            },
            markers: Set<Marker>.of(listMarker),
            polygons: {
              for (int i = 0; i < polygonPoints.length; i++)
                Polygon(
                  polygonId: PolygonId(i.toString()),
                  points: polygonPoints[i],
                  strokeWidth: 1,
                  strokeColor: Colors.amber,
                  fillColor: Colors.green.shade400,
                  // fillColor: const Color(0xFF006491).withOpacity(0.2),
                )
            },
            circles: {
              const Circle(
                circleId: CircleId('1'),
                center: LatLng(
                  -6.502047222222222,
                  113.610575,
                ),
                radius: 15000,
                fillColor: Colors.red,
                strokeWidth: 0,
              )
            },
          ),
          const BackButtonOnMap(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ContainerInMapPage(
                    height: maxHeight * 0.1,
                    width: maxWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: maxWidth * 0.2,
                          child: const Text(
                            '📝 Note: You can customize it in your profile page',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: maxWidth * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Kecepatan Dinas',
                                    style: TextStyle(
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Text(
                                    'Horse Power',
                                    style: TextStyle(
                                      color: Colors.white60,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color: Colors.grey,
                                width: maxWidth * 0.65,
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${widget.kecepatanDinas.toStringAsFixed(1)} knot',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '${widget.horsePower.toStringAsFixed(1)} hp',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: maxHeight * 0.01,
                  ),
                  ContainerInMapPage(
                    height: maxHeight * 0.13,
                    width: maxWidth,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Jarak Tempuh',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                'Waktu Tempuh',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                'BBM Terpakai',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${finalDistance.toStringAsFixed(3).toString().replaceAll('.', ',')} km',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: maxWidth * 0.3,
                                child: Text(
                                  '${hr.toStringAsFixed(0)} Jam ${mn.toStringAsFixed(0)} Menit ${sc.toStringAsFixed(0)} Detik',
                                  softWrap: true,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                '${liter.toStringAsFixed(2)} Liter',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
