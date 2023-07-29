import 'package:flutter/material.dart';
import 'package:rajoongan/app/constants/color.dart';

class ProfileContainer extends StatelessWidget {
  double profileWidth, paddingLeft, emailSize, nameSize, gapSize;
  String nama, namaKapal, imageUrl;

  ProfileContainer({
    super.key,
    required this.profileWidth,
    required this.nama,
    required this.namaKapal,
    required this.imageUrl,
    this.paddingLeft = 0,
    this.nameSize = 15,
    this.emailSize = 13,
    this.gapSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: lightBlue,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          SizedBox(
            width: gapSize,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: TextStyle(
                  fontSize: nameSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                namaKapal,
                style: TextStyle(
                  fontSize: emailSize,
                  fontWeight: FontWeight.w500,
                  color: lightBlue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
