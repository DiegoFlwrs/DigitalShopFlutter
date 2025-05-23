
import 'package:digital_shop/core/constants/app_colors.dart' show AppColors;
import 'package:digital_shop/features/auth/presentation/pages/welcome_page.dart' show AuthButton;
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';

import 'package:flutter/material.dart';

class RestardPage extends StatelessWidget {
  const RestardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_dcalu.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          const CustomImageCard(
            imagePath: 'assets/images/dcalu.png',
            backgroundColor: AppColors.bgPrimary,
            borderColor: AppColors.primary,
            margin: EdgeInsets.only(top: 100, left: 150),
          ),
 
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 220, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.bgContainer,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Restaurar Contraseña',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const CustomTextField(
                          label: 'Correo electrónico',
                          icon: 'email',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: AuthButton(
                            text: 'ENVIAR CÓDIGO',
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            borderColor: AppColors.primary,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Código enviado al correo.'),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
