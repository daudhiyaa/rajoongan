import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.nama,
    required this.namaKapal,
    required this.imageUrl,
  }) : super(key: key);

  final String nama, namaKapal, imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        nama,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        namaKapal,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
