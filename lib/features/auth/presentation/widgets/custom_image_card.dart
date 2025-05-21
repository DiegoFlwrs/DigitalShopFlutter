import 'package:flutter/material.dart';

class CustomImageCard extends StatelessWidget {
  final String imagePath;
  final double? height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomImageCard({
    super.key,
    required this.imagePath,
    this.height = 100,
    required this.backgroundColor,
    required this.borderColor,
    this.borderWidth = 6,
    this.borderRadius = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Image.asset(
        imagePath,
        height: height,
      ),
    );
  }
}
