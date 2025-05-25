import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final double? width; // Propiedad para el ancho
  final double? fontSize; // Nueva propiedad para el tamaño del texto

  const AuthButton({
    Key? key,
    this.iconPath,
    this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
    this.width,
    this.fontSize, // Se incluye en el constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: textColor.withOpacity(0.2),
        onTap: onPressed,
        child: Container(
          height: 55,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  fontSize: fontSize ?? 18, // Se usa fontSize si está definido, si no, 18 por defecto
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
