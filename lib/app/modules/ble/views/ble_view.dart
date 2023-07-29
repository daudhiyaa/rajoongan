import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';
import 'package:rajoongan/app/components/container/container_in_map.dart';
import 'package:rajoongan/app/constants/constants.dart';
import 'package:rajoongan/app/constants/polygon_points.dart';

class BLEView extends StatefulWidget {
  BLEView({
    Key? key,
  }) : super(key: key);

  @override
  State<BLEView> createState() => _BLEViewState();
}

class _BLEViewState extends State<BLEView> {
  final Completer<GoogleMapController> _controller = Completer();

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResults = [];
  final String namaDeviceBLE = 'ESP32-BLE-Server';

  List<List<double>> listLatLngs = [];
  bool isRecording = false;
  int counterRecord = 0;
  String filename = "rajoongan-travelHistory";

  List<Marker> listMarker = [];
  double finalDistance = 0, liter = 0, hr = 0, mn = 0, sc = 0;

  TextEditingController kecepatanController = TextEditingController();
  TextEditingController hpController = TextEditingController();

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();

    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      List<BluetoothCharacteristic> characteristics = service.characteristics;
      for (BluetoothCharacteristic characteristic in characteristics) {
        if (characteristic.uuid.toString() == bleUUID) {
          _subscribeToCharacteristic(characteristic);
        }
        await Future.delayed(const Duration(seconds: 15));
      }
    }
  }

  void updateCamera() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(ltNow, lngNow),
          zoom: 18,
        ),
      ),
    );
    setState(() {});
  }

  dynamic value;
  late double ltNow, lngNow;
  void _subscribeToCharacteristic(BluetoothCharacteristic characteristic) {
    characteristic.setNotifyValue(true);
    characteristic.value.listen((data) {
      value = String.fromCharCodes(data);
      List<String> words = value.split(' ');

      ltNow = double.parse(words[0]);
      lngNow = double.parse(words[1]);
      updateCamera();
      setState(() {});
      // print('Received data: $data');
      // print('Final Value: $value');

      if (isRecording) {
        List<double> temp = [];
        temp.add(ltNow);
        temp.add(lngNow);
        listLatLngs.add(temp);

        listMarker.add(
          Marker(
            markerId: MarkerId('id$value'),
            position: LatLng(ltNow, lngNow),
          ),
        );
      }
    });
  }

  void startScan() {
    flutterBlue.startScan();
    flutterBlue.scanResults.listen((results) {
      scanResults = results;
      for (ScanResult result in results) {
        if (result.device.name == namaDeviceBLE) {
          connectToDevice(result.device);
          flutterBlue.stopScan();
          break;
        }
      }
      setState(() {});
    });
  }

  void writeListToFile(String pathFile) {
    final file = File(pathFile);
    final sink = file.openWrite();

    for (final item in listLatLngs) {
      sink.writeln(item);
    }

    sink.close();
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

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

  void calculateLiterBBM(double hp) {
    liter = 0.16 * hp * hr;
  }

  void getPermissions() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    getPermissions();
    counterRecord = 0;
    filename = "rajoongan-travelHistory";
    listLatLngs = [];
    listMarker = [
      const Marker(
        markerId: MarkerId('dest'),
        position: LatLng(0, 0),
        infoWindow: InfoWindow(title: "Destination"),
      ),
      const Marker(
        markerId: MarkerId('src'),
        position: LatLng(1, 1),
        infoWindow: InfoWindow(title: "Start"),
      ),
    ];
    isRecording = false;

    ltNow = 0;
    lngNow = 0;
    super.initState();
    startScan();
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  bool isStart = false;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ltNow == 0 || lngNow == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    strokeWidth: 4,
                    backgroundColor: Colors.red,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Waiting GPS...')
                ],
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                    mapType: MapType.hybrid,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(ltNow, lngNow),
                      zoom: 15.5,
                    ),
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
                    onTap: (LatLng latLng) {
                      if (isStart) {
                        listMarker[1] = Marker(
                          markerId: const MarkerId('src'),
                          position: latLng,
                          infoWindow: const InfoWindow(title: "Start"),
                        );
                      } else {
                        listMarker[0] = Marker(
                          markerId: const MarkerId('dest'),
                          position: latLng,
                          infoWindow: const InfoWindow(title: "Destination"),
                        );
                      }
                      isStart = !isStart;

                      calculateDistance(
                        listMarker[0].position.latitude,
                        listMarker[0].position.longitude,
                        listMarker[1].position.latitude,
                        listMarker[1].position.longitude,
                      );
                      calculateTravelingTime(
                        finalDistance,
                        double.parse(kecepatanController.text),
                      );
                      calculateLiterBBM(double.parse(hpController.text));
                      setState(() {});
                    }),
                Transform.scale(
                  scale: 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isRecording = !isRecording;
                                counterRecord++;
                              });

                              final dir = await getExternalStorageDirectory();
                              // print("download:${dir!.path}");

                              Directory? directory =
                                  Directory('/storage/emulated/0/Documents');
                              // print(directory.path);

                              DateTime now = DateTime.now();
                              String timeNow =
                                  "${now.day}-${now.month}-${now.year}_${now.hour}:${now.minute}:${now.second}";

                              if (!isRecording && counterRecord > 1) {
                                final pathFile =
                                    "${dir!.path}/${filename}_$now.txt";
                                String snackbarTitle = "";

                                try {
                                  writeListToFile(pathFile);
                                  snackbarTitle =
                                      "Your data will be saved in:\n'$pathFile'";
                                } on FileSystemException catch (e) {
                                  snackbarTitle = e.message;
                                }

                                final snackBar = SnackBar(
                                  content: Text(
                                    snackbarTitle,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.blueGrey,
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                isRecording ? Colors.red : Colors.green,
                              ),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(4),
                              shadowColor: MaterialStateProperty.all<Color>(
                                Colors.black.withOpacity(1),
                              ),
                            ),
                            child: Text(isRecording ? "Stop" : "Record"),
                          )
                        ],
                      ),
                      Transform.scale(
                        scale: 0.85,
                        alignment: Alignment.centerLeft,
                        child: ContainerInMapPage(
                          height: maxHeight * 0.1,
                          width: maxWidth,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: maxWidth * 0.45,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.white60,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: kecepatanController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: "dalam satuan knot",
                                          hintStyle: TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12,
                                          ),
                                          labelText: "Kecepatan Dinas",
                                          labelStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: maxWidth * 0.45,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.white60,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: hpController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: "dalam satuan hp/pk",
                                          hintStyle: TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12,
                                          ),
                                          labelText: "Horse Power",
                                          labelStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.85,
                        alignment: Alignment.centerLeft,
                        child: ContainerInMapPage(
                          height: maxHeight * 0.13,
                          width: maxWidth,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                      ),
                    ],
                  ),
                ),
                const BackButtonOnMap(),
              ],
            ),
    );
  }
}
