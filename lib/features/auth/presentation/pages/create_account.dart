import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:digital_shop/features/auth/domain/repositories/implement/auth_repository.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:digital_shop/features/auth/presentation/controllers/registrer_controller.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/custom_image_card.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:digital_shop/core/constants/app_colors.dart' show AppColors;
import 'package:form_field_validator/form_field_validator.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  final controller = RegistrerController(
    LoginUseCase(
      AuthRepositoryImpl(
        AuthRemoteDatasource(ApiService()),
      ),
    ),
  );

  final _formKey = GlobalKey<FormState>();

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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Registrate',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
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
                                  controller: controller.nameController,
                                  validator: RequiredValidator(errorText: 'Campo requerido'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: 'Apellido',
                                  icon: 'person',
                                  backgroundColor: AppColors.bgPrimary,
                                  textColor: AppColors.black,
                                  borderColor: AppColors.primary,
                                  borderWidth: 3.0,
                                  borderRadius: 10.0,
                                  controller: controller.apellidoController,
                                  validator: RequiredValidator(errorText: 'Campo requerido'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: 'Correo electrónico',
                            icon: 'email',
                            backgroundColor: AppColors.bgPrimary,
                            textColor: AppColors.black,
                            borderColor: AppColors.primary,
                            borderWidth: 3.0,
                            borderRadius: 10.0,
                            controller: controller.emailController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Campo obligatorio'),
                              EmailValidator(errorText: 'Correo inválido'),
                            ]),
                          ),
                          const SizedBox(height: 20),
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
                            validator: MinLengthValidator(6, errorText: 'Mínimo 6 caracteres'),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: 'Confirmar contraseña',
                            icon: 'lock',
                            backgroundColor: AppColors.bgPrimary,
                            textColor: AppColors.black,
                            borderColor: AppColors.primary,
                            borderWidth: 3.0,
                            borderRadius: 10.0,
                            obscureText: true,
                            controller: controller.confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obligatorio';
                              } else if (value != controller.passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: AuthButton(
                              text: 'REGISTRAR',
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              borderColor: AppColors.primary,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.registrer(context);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'Al continuar, aceptas los Términos y Condiciones',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
