import 'package:flutter/material.dart';
import 'package:rajoongan/app/constants/color.dart';

class PageTitle extends StatelessWidget {
  String title1, title2;
  double sizedBoxTop, sizedBoxBottom;
  PageTitle({
    super.key,
    required this.title1,
    required this.title2,
    this.sizedBoxTop = 25,
    this.sizedBoxBottom = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizedBoxTop,
        ),
        Text(
          title1,
          style: const TextStyle(
            fontSize: 18,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title2,
          style: const TextStyle(
            fontSize: 14,
            color: lightBlue,
          ),
        ),
        SizedBox(
          height: sizedBoxBottom,
        ),
      ],
    );
  }
}
