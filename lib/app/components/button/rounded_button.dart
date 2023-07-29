import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rajoongan/app/constants/color.dart';

class RoundedBotton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textcolor;
  const RoundedBotton({
    super.key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textcolor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: Get.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 40),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
