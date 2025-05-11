import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey500),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}