import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:rajoongan/app/components/sidebar/side_menu.dart';
import 'package:rajoongan/app/components/button/hamburger_button.dart';
import 'package:rajoongan/app/constants/constants.dart';
import 'package:rajoongan/app/pages/home/home_screen.dart';
import 'package:rajoongan/app/pages/edit_profile/edit_profile.dart';
import 'package:rajoongan/app/utils/rive_utils.dart';
import 'package:rive/rive.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late Animation<double> borderRadiusAnimation;

  Position? positionNow;

  late Map weatherData;
  String weatherIcon = '10d';
  String weather = 'Weather';
  double temp = 0;
  double seaLevel = 0;
  double windSpeed = 0;

  User? user;
  Map<String, dynamic>? userData;
  Map listTangkapan = {};
  String username = '', namaKapal = '', jenisMesin = '', kelompokNelayan = '';
  String uid = '';
  double kecepatanDinas = 0;
  double horsePower = 0;

  Map listRiwayatPerjalanan = {};

  String dataFromChild = '';
  dynamic ref;
  String? imageUrl;

  Future<void> fetchWeatherData() async {
    const String apiKey = openWeatherAPIKey;

    final Uri uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${positionNow!.latitude}&lon=${positionNow!.longitude}&appid=$apiKey',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      weatherData = data;
      weather = weatherData['weather'][0]['main'];
      weatherIcon = weatherData['weather'][0]['icon'];
      temp = weatherData['main']['temp'] - 273;
      // windSpeed = double.parse(weatherData['wind']['speed'].toString());
      windSpeed = weatherData['wind']['speed'];
      // seaLevel = weatherData['main']['sea_level'] / 1000;
    } else {
      print('Error: ${response.statusCode}');
    }
    setState(() {});
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getPositionNow() async {
    positionNow = await _getGeoLocationPosition();
    setState(() {});
    fetchWeatherData();
  }

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return snapshot;
  }

  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot snapshot = await getUserDocument(uid);
    if (snapshot.exists) {
      userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        username = userData!['nama'];
        namaKapal = userData!['namaKapal'];
        jenisMesin = userData!['jenisMesin'];
        kelompokNelayan = userData!['kelompokNelayan'];

        listTangkapan = userData!['listTangkapan'];
        kecepatanDinas = double.parse(userData!['kecepatanDinas']);
        horsePower = double.parse(userData!['horsePower']);

        listRiwayatPerjalanan = userData!['listRiwayatPerjalanan'];
      }
    } else {
      print('Document does not exist');
    }
  }

  @override
  void initState() {
    getPositionNow();
    weatherData = {};

    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    setState(() {});
    fetchUserData(uid);

    ref = storage.FirebaseStorage.instance.ref().child("images").child(uid);
    if (ref != null) getDataFromStorage();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    borderRadiusAnimation = Tween<double>(begin: 0, end: 24).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void getDataFromChild(String data) {
    setState(() {
      dataFromChild = data;
    });
  }

  Future<void> getDataFromStorage() async {
    try {
      imageUrl = await ref.getDownloadURL();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          positionNow == null ? Colors.white : const Color(0xFF17203A),
      body: positionNow == null
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
                  Text('Loading Your Location...'),
                ],
              ),
            )
          : Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width: 288,
                  left: isSideMenuClosed ? -288 : 0,
                  height: maxHeight,
                  child: SideMenu(
                    username: username,
                    namaKapal: namaKapal,
                    callback: getDataFromChild,
                    imageUrl: imageUrl!,
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        animation.value - 30 * animation.value * pi / 180),
                  child: Transform.translate(
                    offset: Offset(animation.value * 265, 0),
                    child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadiusAnimation.value),
                        ),
                        child: dataFromChild.contains("profile")
                            ? PageEditProfile(
                                jenisMesin: jenisMesin,
                                kecepatanDinas: kecepatanDinas.toString(),
                                kelompokNelayan: kelompokNelayan,
                                nama: username,
                                namaKapal: namaKapal,
                                horsePower: horsePower.toString(),
                                uid: uid,
                                imageUrl: imageUrl,
                              )
                            : HomeScreen(
                                username: username,
                                namaKapal: namaKapal,
                                listTangkapan: listTangkapan,
                                kecepatanDinas: kecepatanDinas,
                                horsePower: horsePower,
                                maxWidth: maxWidth,
                                ltNow: positionNow!.latitude,
                                lngNow: positionNow!.longitude,
                                weatherIcon: weatherIcon,
                                temp: temp,
                                weather: weather,
                                windSpeed: windSpeed,
                                seaLevel: seaLevel,
                                listRiwayatPerjalanan: listRiwayatPerjalanan,
                                imageUrl: imageUrl!,
                              ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  left: isSideMenuClosed ? 0 : 220,
                  top: 16,
                  child: HamburgerBtn(
                    riveOnInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: "State Machine",
                      );
                      isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                      isSideBarClosed.value = true;
                    },
                    press: () {
                      isSideBarClosed.value = !isSideBarClosed.value;
                      if (isSideMenuClosed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                      setState(() {
                        isSideMenuClosed = isSideBarClosed.value;
                      });
                    },
                  ),
                )
              ],
            ),
    );
  }
}
