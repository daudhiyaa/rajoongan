import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/carousel_box.dart';

class CarouselContainer extends StatefulWidget {
  final String weatherIcon, weather;
  final double temp, windSpeed, seaLevel;
  final int currentHour;
  CarouselContainer({
    super.key,
    this.weatherIcon = '10d',
    this.weather = 'Rainy',
    this.temp = 0,
    this.windSpeed = 0,
    this.seaLevel = 0,
    required this.currentHour,
  });

  @override
  State<CarouselContainer> createState() => _CarouselContainerState();
}

class _CarouselContainerState extends State<CarouselContainer> {
  double currentPageValue = 0;
  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      "https://openweathermap.org/img/wn/${widget.weatherIcon}@2x.png",
      "assets/images/wind.png",
      "assets/images/water.png",
    ];

    if (widget.weather == "Clear") {
      if (widget.currentHour >= 18 && widget.currentHour < 4) {
        urls[0] = "assets/weather/Moon.png";
      } else {
        urls[0] = "assets/weather/Sun.png";
      }
    } else if (widget.weather == "Clouds") {
      urls[0] = "assets/weather/Clouds.png";
    } else if (widget.weather == "Rain") {
      urls[0] = "assets/weather/Rain.png";
    } else if (widget.weather == "Drizzle") {
      urls[0] = "assets/weather/Drizzle.png";
    } else if (widget.weather == "Thunderstorm") {
      urls[0] = "assets/weather/Thunderstorm.png";
    } else if (widget.weather == "Snow") {
      urls[0] = "assets/weather/Snow.png";
    } else if (widget.weather == "Tornado" || widget.weather == "Squall") {
      urls[0] = "assets/weather/Tornado.png";
    } else if (widget.weather == "Mist" ||
        widget.weather == "Fog" ||
        widget.weather == "Haze") {
      urls[0] = "assets/weather/Wind.png";
    }
    // else => Haze, Smoke, Dust, Sand, Ash

    List<String> value = [
      '${widget.temp.toStringAsFixed(1)} C',
      '${widget.windSpeed.toStringAsFixed(2)} m/s',
      '${widget.seaLevel.toStringAsFixed(1)} m'
    ];

    List<String> str1 = ['Kondisi', 'Kecepatan', 'Tinggi'];
    List<String> str2 = ['Cuaca', 'Angin', 'Ombak'];

    List<String?> weatherDesc = [widget.weather, null, null];

    return PageView.builder(
      controller: controller,
      itemCount: urls.length,
      itemBuilder: (context, index) {
        double differece = (index - currentPageValue).abs();
        differece = min(1, differece);

        return Center(
          child: CarouselBox(
            weatherIcon: urls[index],
            weather: weatherDesc[index],
            value: value[index],
            scale: 1 - (differece * 0.3),
            str1: str1[index],
            str2: str2[index],
          ),
        );
      },
    );
  }
}
