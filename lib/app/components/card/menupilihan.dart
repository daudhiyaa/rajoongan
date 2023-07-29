import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rajoongan/app/constants/color.dart';

class MenuPilihan extends StatelessWidget {
  const MenuPilihan({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 150,
        height: 230,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightBlue,
              Color.fromARGB(255, 134, 181, 255),
              Colors.white
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 9,
            )
          ],
        ),
        child: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                softWrap: true,
              )
            ],
          );
        }),
      ),
    );
  }
}
