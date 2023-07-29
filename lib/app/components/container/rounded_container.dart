import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double verticalMargin;
  final double borderRadius;
  final Color color;
  final double width;

  const RoundedContainer({
    super.key,
    required this.child,
    this.verticalPadding = 0,
    this.verticalMargin = 10,
    this.borderRadius = 30,
    this.color = const Color(0xFF63AAFF),
    this.width = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding),
      width: size.width * width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
