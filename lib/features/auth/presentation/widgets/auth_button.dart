import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  const AuthButton({
    super.key,
    required this.text,
    this.iconPath,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onPressed, required bool isIconOnly,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 4)
              : BorderSide.none,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}