import 'package:flutter/material.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:digital_shop/core/constants/app_colors.dart' show AppColors;
class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
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
                            'Registrate',
                            style: TextStyle(
                              fontSize:30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'Nombre',
                                icon: 'person',
                                backgroundColor: AppColors.bgPrimary,
                                textColor: AppColors.black,
                                borderColor: AppColors.primary,
                                borderWidth: 3.0,
                                borderRadius: 10.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                label: 'Apellido',
                                icon: 'person',
                                backgroundColor: AppColors.bgPrimary,
                                textColor: AppColors.black,
                                borderColor: AppColors.primary,
                                borderWidth: 3.0,
                                borderRadius: 10.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const CustomTextField(
                          label: 'Correo electrónico',
                          icon: 'email',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                        ),
                        const SizedBox(height: 20),
                        const CustomTextField(
                          label: 'Contraseña',
                          icon: 'lock',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                          obscureText: true, 
                        ),
                        const SizedBox(height: 20),
                        const CustomTextField(
                          label: 'Confirmar contraseña',
                          icon: 'lock',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                          obscureText: true, 
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: AuthButton(
                            text: 'REGISTRAR',
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
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Al continuar, aceptas los Terminos y Condiciones',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.white,
                            ),
                          ),
                        ),
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
