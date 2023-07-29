import 'package:flutter/material.dart';

class BackButtonOnMap extends StatelessWidget {
  const BackButtonOnMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 45),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3),
              blurRadius: 8,
            )
          ],
        ),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
