import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final bool obscureText;
  final TextEditingController? controller; // ✅ Nuevo parámetro

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.onPressed,
    this.obscureText = false,
    this.controller, // ✅ Incluido en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ✅ Se usa aquí
      obscureText: obscureText,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(_getIconData(icon!), color: textColor) : null,
        hintText: label,
        hintStyle: TextStyle(color: textColor),
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            width: borderWidth ?? 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            width: borderWidth ?? 2.0,
          ),
        ),
      ),
    );
  }

  IconData? _getIconData(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person;
      case 'email':
        return Icons.email;
      case 'lock':
        return Icons.lock;
      case 'code':
        return Icons.code;
      case 'search':
        return Icons.search;
      default:
        return Icons.help_outline;
    }
  }
}
