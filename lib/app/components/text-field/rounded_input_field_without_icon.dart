import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/container/rounded_container.dart';
import 'package:rajoongan/app/constants/color.dart';

class RoundedInputFieldWithoutIcon extends StatelessWidget {
  final String hintText;
  final String labelText;
  final ValueChanged<String> onChanged;
  final Color color;
  final double fontSize;
  final double width;
  final TextEditingController textEditingController;
  final TextInputType inputType;

  const RoundedInputFieldWithoutIcon({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    this.color = Colors.white70,
    this.fontSize = 18,
    this.width = 0.8,
    required this.textEditingController,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      verticalPadding: 0,
      borderRadius: 20,
      width: width,
      child: TextField(
        keyboardType: inputType,
        controller: textEditingController,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: fontSize,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
