import 'package:flutter/material.dart';
import 'package:rajoongan/app/constants/color.dart';

class FinalstateButton extends StatelessWidget {
  FinalstateButton({
    super.key,
    required this.onpress,
    required this.text,
    this.verticalPadding = 15,
    this.horizontalPadding = 55,
  });
  final void Function() onpress;
  final String text;
  double verticalPadding, horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          primaryColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
        ), // Customize padding
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(4),
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.black.withOpacity(1),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
