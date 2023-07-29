import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/styles/pageviewstyle.dart';

class CarouselBox extends StatelessWidget {
  final String weatherIcon, value;
  final String? weather;
  final String str1, str2;
  final double scale;

  CarouselBox({
    this.scale = 1,
    required this.weatherIcon,
    required this.weather,
    required this.value,
    required this.str1,
    required this.str2,
  });

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: parentStyle.clone()
        ..background.color(Colors.white)
        ..width(400 * scale)
        ..height(250 * scale),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 134, 181, 255), Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                // color: Colors.grey,
                image: weatherIcon.contains('asset')
                    ? DecorationImage(
                        image: AssetImage(weatherIcon),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              child: weatherIcon.contains('asset')
                  ? null
                  : Image.network(
                      weatherIcon,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // color: Colors.amber,
                  width: Get.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        str1,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        str2,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 50,
                  color: primaryColor,
                ),
                Container(
                  // color: Colors.amber,
                  width: Get.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (weather != null)
                        Text(
                          weather!,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
