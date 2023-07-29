import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajoongan/app/components/card/profile_card_sidebar.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/models/rive_asset.dart';
import 'package:rajoongan/app/routes/app_pages.dart';
import 'package:rajoongan/app/utils/rive_utils.dart';
import 'package:rive/rive.dart';

import 'side_menu_tile.dart';

class SideMenu extends StatefulWidget {
  final String username, namaKapal, imageUrl;
  final Function(String) callback;
  SideMenu({
    super.key,
    required this.username,
    required this.namaKapal,
    required this.callback,
    required this.imageUrl,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: sideBarBG,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                nama: widget.username,
                namaKapal: widget.namaKapal,
                imageUrl: widget.imageUrl,
              ),
              const TitleList(title: "Browse"),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: menu.stateMachineName,
                    );
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    if (menu.title.contains("Profil")) {
                      widget.callback('edit-profile');
                    } else {
                      widget.callback('');
                    }

                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAllNamed(Routes.START);
                },
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleList extends StatelessWidget {
  final String title;
  const TitleList({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white70),
      ),
    );
  }
}
