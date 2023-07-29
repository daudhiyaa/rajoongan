import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';
import 'package:rajoongan/app/components/container/rounded_container.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/pages/pengetahuan/karantina_rajungan.dart';
import 'package:rajoongan/app/pages/daerah_tangkapan/polygon.dart';

class PengetahuanPage extends StatelessWidget {
  const PengetahuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackButtonOnMap(),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageTitle(
                    title1: "Tau Lebih",
                    title2: "Informasi seputar penangkapan rajungan.",
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapPolygonPage(),
                        ),
                      );
                    },
                    child: RoundedContainer(
                      verticalMargin: 5,
                      borderRadius: 15,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: const Center(
                          child: Text(
                            "Lokasi Penangkapan Potensial",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KarantinaRajunganPage(),
                        ),
                      );
                    },
                    child: RoundedContainer(
                      verticalMargin: 5,
                      borderRadius: 15,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: const Center(
                          child: Text(
                            "Karantina Rajungan Bertelur",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
