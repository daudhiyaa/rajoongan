import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: Get.height * 0.4,
              // color: Colors.yellow,
              child: Image.asset(
                // "assets/images/rajoongan.png",
                "assets/icons/rajoongan-icon.png",
                height: Get.height * 0.5,
                width: Get.width * 0.5,
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "assets/images/laut.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
