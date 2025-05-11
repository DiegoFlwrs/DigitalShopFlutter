import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';
import 'package:lottie/lottie.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          height: 350,
          child:
         Lottie.network('https://lottie.host/6328f4fc-4132-4cee-a01a-28a69e7f26d2/0let8bu9Wq.json')
        ),
        Text(
          'Bienvenido a Digital Shop',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Tu estilo, a un clic de distancia',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}