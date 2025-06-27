import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderSize;
  final double? borderRadius; // nuevo parámetro

  const AuthButton({
    Key? key,
    this.iconPath,
    this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
    this.width,
    this.fontSize,
    this.padding,
    this.borderSize,
    this.borderRadius, // agregar al constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? 16); // uso del valor o default

    return Material(
      color: backgroundColor,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        splashColor: textColor.withOpacity(0.2),
        onTap: onPressed,
        child: Container(
          height: 55,
          width: width,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: borderColor,
              width: borderSize ?? 2,
            ),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                Image.asset(iconPath!, height: 26, width: 26),
                const SizedBox(width: 14),
              ],
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: fontSize ?? 18,
                  letterSpacing: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
