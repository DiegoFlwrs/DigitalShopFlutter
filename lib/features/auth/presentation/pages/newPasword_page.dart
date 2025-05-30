import 'package:digital_shop/core/constants/app_colors.dart' show AppColors;
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:digital_shop/features/auth/domain/repositories/implement/auth_repository.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:digital_shop/features/auth/presentation/controllers/resetPassword_controller.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  NewPassword({super.key});

  final controller = ResetPasswordController(
    LoginUseCase(
      AuthRepositoryImpl(
        AuthRemoteDatasource(ApiService()),
      ),
    ),
  );

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
                            'Restaurar Contraseña',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Icons.abc,
                        const SizedBox(height: 25),
                        CustomTextField(
                          label: 'Contraseña',
                          icon: 'lock',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                          obscureText: true,
                          controller: controller.newPasswordController,
                        ),
                        const SizedBox(height: 25),
                        CustomTextField(
                          label: 'Confirmar Contraseña',
                          icon: 'lock',
                          backgroundColor: AppColors.bgPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          borderWidth: 3.0,
                          borderRadius: 10.0,
                          obscureText: true,
                          controller: controller.confirmPasswordController,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: AuthButton(
                            text: 'CAMBIAR CONTRASEÑA',
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            borderColor: AppColors.primary,
                            onPressed: () {
                              // Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginPage()));
                              controller.resetPassword(context);
                            },
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
