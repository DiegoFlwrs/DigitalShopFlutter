import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_dcalu.png'), // imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
          ),
            const CustomImageCard(
            imagePath: 'assets/images/dcalu.png',
            backgroundColor: AppColors.bgPrimary,
            borderColor: AppColors.primary,
            margin: EdgeInsets.only(top: 120, left: 150),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 260, left: 30, right: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    height: 400,
                    decoration: BoxDecoration(
                      color: AppColors.bgContainer,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      SizedBox(height: 30),
                        CustomTextField(
                          label: 'Correo',
                          icon: 'person',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                        ),
                        SizedBox(height: 35),
                        CustomTextField(
                          label: 'Contraseña',
                          icon: 'lock',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                          obscureText: true,
                        ),
                        SizedBox(height: 35),
                        AuthButton(
                        text: 'INGRESAR',
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white, 
                        borderColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                        const Text(
                          'eh olvidado la contraseña',
                          style: TextStyle(color: AppColors.primary),
                        ),
                ],
              ),          
            )
          )
        ],
      ),
    );
  }
}
