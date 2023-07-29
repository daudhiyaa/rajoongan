import 'package:flutter/material.dart';

import 'package:rajoongan/app/components/container/carousel_container.dart';
import 'package:rajoongan/app/components/card/menupilihan.dart';
import 'package:rajoongan/app/components/card/profile_card_home.dart';
import 'package:rajoongan/app/components/clock.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/modules/hasil_tangkap/views/hasil_tangkap_view.dart';
import 'package:rajoongan/app/modules/map/views/map_view.dart';
import 'package:rajoongan/app/pages/history_perjalanan/history_perjalanan.dart';
import 'package:rajoongan/app/pages/pengetahuan/pengetahuan.dart';

class CustomTitle extends StatelessWidget {
  Widget child;
  CustomTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Container(
      width: maxWidth * 0.6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final double ltNow, lngNow;
  final String weatherIcon, weather;
  double temp, windSpeed, seaLevel;

  final String username, namaKapal;
  final double kecepatanDinas, horsePower;
  final Map listTangkapan;

  final Map listRiwayatPerjalanan;

  final String imageUrl;

  HomeScreen({
    super.key,
    required this.maxWidth,
    this.ltNow = 0,
    this.lngNow = 0,
    this.weatherIcon = '10d',
    this.weather = 'Rainy',
    this.temp = 0,
    this.windSpeed = 0,
    this.seaLevel = 0,
    required this.username,
    required this.namaKapal,
    required this.listTangkapan,
    required this.kecepatanDinas,
    required this.horsePower,
    required this.listRiwayatPerjalanan,
    required this.imageUrl,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            ProfileContainer(
              profileWidth: maxWidth * 0.2,
              nama: username,
              namaKapal: namaKapal,
              imageUrl: imageUrl,
              paddingLeft: 30,
              nameSize: 18,
              emailSize: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                CustomTitle(
                  child: const Clock(),
                ),
              ],
            ),
            Container(
              // color: Colors.amber,
              height: 250,
              child: CarouselContainer(
                weatherIcon: weatherIcon,
                temp: temp,
                weather: weather,
                windSpeed: windSpeed,
                seaLevel: seaLevel,
                currentHour: currentHour,
              ),
            ),
            Column(
              children: [
                CustomTitle(
                  child: const Text(
                    'Siapkan Perjalananmu',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(
                            ltNow: ltNow,
                            lngNow: lngNow,
                            kecepatanDinas: kecepatanDinas,
                            horsePower: horsePower,
                          ),
                        ),
                      );
                    },
                    child: const MenuPilihan(
                      image: "assets/images/peta.png",
                      title: "Peta Rajungan",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HasilTangkapPage(
                            listTangkapan: listTangkapan,
                          ),
                        ),
                      );
                    },
                    child: const MenuPilihan(
                      image: "assets/images/hasil.png",
                      title: "Hasil Tangkap",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 30,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PengetahuanPage()),
                      );
                    },
                    child: const MenuPilihan(
                      image: "assets/images/taulebih.png",
                      title: "Tau Lebih",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryPerjalanan(
                            listRiwayatPerjalanan: listRiwayatPerjalanan,
                          ),
                        ),
                      );
                    },
                    child: const MenuPilihan(
                      image: "assets/images/riwayatperjalanan.png",
                      title: "Riwayat Perjalanan",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
