import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/container/rounded_container.dart';
import 'package:rajoongan/app/constants/color.dart';

class RoundedInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  final Color labelTextColor;
  final TextEditingController textEditingController;
  final double fontSize;
  final Widget? suffixIcon;
  final bool obsecureText, enableSuggestion, autoCorrect;

  const RoundedInputField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.textEditingController,
    this.icon = Icons.person,
    this.iconColor = primaryColor,
    this.labelTextColor = Colors.white54,
    this.fontSize = 18,
    this.suffixIcon,
    this.obsecureText = false,
    this.enableSuggestion = true,
    this.autoCorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: TextField(
        controller: textEditingController,
        obscureText: obsecureText,
        enableSuggestions: enableSuggestion,
        autocorrect: autoCorrect,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelTextColor,
            fontSize: fontSize,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
