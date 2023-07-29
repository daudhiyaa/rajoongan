import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pilih Menu".toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: lightBlue,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuStart(
                        onTap: () => {
                          if (_auth.currentUser != null)
                            Get.toNamed(Routes.HOME)
                          else
                            Get.toNamed(Routes.LOGIN)
                        },
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        title1: "Menu Utama",
                        title2: "Dengan Internet",
                        icon: CupertinoIcons.cursor_rays,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MenuStart(
                        onTap: () => Get.toNamed(Routes.BLE),
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        title1: "Bluetooth",
                        title2: "Tanpa Internet",
                        icon: CupertinoIcons.bluetooth,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuStart extends StatelessWidget {
  double maxWidth, maxHeight;
  double fontTitle1;
  String title1, title2;
  IconData icon;
  void Function() onTap;

  MenuStart({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
    this.fontTitle1 = 16,
    required this.title1,
    required this.title2,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: maxHeight * 0.15,
        width: maxWidth * 0.3,
        // margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              Color.fromARGB(255, 134, 181, 255),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontTitle1,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              title2,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.white54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
