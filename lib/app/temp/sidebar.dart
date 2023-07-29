import 'package:flutter/material.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:rajoongan/app/components/card/profile_card_home.dart';
import 'package:rajoongan/app/constants/color.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            // color: Colors.red,
            height: maxHeight * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ProfileContainer(
                //   profileWidth: maxWidth * 0.18,
                //   email: "youremail@gmail.com",
                //   name: "Your Name Here",
                //   urlImage: "assets/images/profile.png",
                // ),
              ],
            ),
          ),
          Container(
            // color: Colors.red,
            height: maxHeight * 0.65,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: primaryColor,
                  title: const Text(
                    'Profil Akun',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Handle menu item 1 tap
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF535763),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: const Text(
                    'Pengaturan',
                    style: TextStyle(
                      color: Color(0xFF535763),
                    ),
                  ),
                  onTap: () {
                    // Handle menu item 2 tap
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFD1D3D4),
            thickness: 0.5,
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text(
              'Mode Tampilan',
              style: TextStyle(
                  color: Color(0xFF535763), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            alignment: Alignment.centerLeft,
            // child: LiteRollingSwitch(
            //   // width: 250,
            //   onSwipe: () {},
            //   onDoubleTap: () {},
            //   onTap: () {},
            //   value: false,
            //   animationDuration: const Duration(milliseconds: 300),
            //   textOn: 'light',
            //   textOff: 'dark',
            //   colorOn: const Color(0xFFF0F0F0),
            //   colorOff: Colors.grey,
            //   iconOn: Icons.sunny,
            //   iconOff: Icons.dark_mode,
            //   textSize: 16.0,
            //   onChanged: (bool state) {
            //     // print('Current State of SWITCH IS: $state');
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
