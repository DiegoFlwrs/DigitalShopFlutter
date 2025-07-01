import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:digital_shop/features/auth/domain/repositories/implement/auth_repository.dart';
import 'package:digital_shop/features/auth/domain/usecases/login_usecase.dart';
import 'package:digital_shop/features/auth/presentation/controllers/login_controller.dart';
import 'package:digital_shop/features/auth/presentation/pages/restard_page.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final controller = LoginController(
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
          // Fondo con imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_dcalu.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo de la app
          const CustomImageCard(
            imagePath: 'assets/images/dcalu.png',
            backgroundColor: AppColors.bgPrimary,
            borderColor: AppColors.primary,
            margin: EdgeInsets.only(top: 120, left: 150),
          ),
          // Formulario
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            label: 'Correo',
                            icon: 'person',
                            backgroundColor: AppColors.bgPrimary,
                            textColor: AppColors.black,
                            borderColor: AppColors.primary,
                            borderWidth: 3.0,
                            borderRadius: 10.0,
                            controller: controller.emailController,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'Campo obligatorio'),
                            //   EmailValidator(errorText: 'Correo inválido'),
                            // ]),
                          ),
                          const SizedBox(height: 35),
                          CustomTextField(
                            label: 'Contraseña',
                            icon: 'lock',
                            backgroundColor: AppColors.bgPrimary,
                            textColor: AppColors.black,
                            borderColor: AppColors.primary,
                            borderWidth: 3.0,
                            borderRadius: 10.0,
                            obscureText: true,
                            controller: controller.passwordController,
                            // validator: RequiredValidator(errorText: 'Campo obligatorio'),
                          ),
                          const SizedBox(height: 20),
                          AuthButton(
                            text: 'INGRESAR',
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            borderColor: AppColors.primary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.login(context);
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestardPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'He olvidado la contraseña',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
