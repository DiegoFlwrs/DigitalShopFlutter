import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.bdDragadeIA,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // para que se vea el gradiente
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "DIGITAL SHOP",
                style: AppTextStyles.textShadow,
              ),
              Column(
                children: [
                  const Text(
                    "¿Qué quieres Comprar?",
                    style: AppTextStyles.headlineGrande,
                    textAlign: TextAlign.center,
                  ),
                  ClipRRect(
                    child: Lottie.asset(
                      'assets/animations/circulo.json',
                      height: 150,
                      repeat: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: CustomTextField(
                      label: 'Buscar',
                      icon: 'search',
                      backgroundColor: AppColors.bgPrimary,
                      textColor: AppColors.black,
                      borderColor: AppColors.primary,
                      borderWidth: 3.0,
                      borderRadius: 10.0,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: AuthButton(
                      text: 'BUSCAR',
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      borderColor: AppColors.primary,
                      width: 120,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
