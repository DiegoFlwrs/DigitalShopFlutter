import 'package:digital_shop/core/providers/auth_provider.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/pages/faqpage.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.bgPrimary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 100),
            child: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return Stack(
                  children: [
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.25),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Lottie.asset(
                                'assets/animations/welcome_animation.json',
                                height: 250,
                                repeat: true,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.white, Colors.white70],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: const Text(
                              '¡Descubre tu estilo único!',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.textShadow,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Conéctate con la moda que te define y vive la experiencia Digital Shop. Aquí, cada prenda cuenta una historia.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          iconPath: 'assets/icons/google.png',
                          text: 'Continuar con Google',
                          backgroundColor: Colors.white,
                          borderColor: Colors.grey,
                          textColor: Colors.black87,
                          onPressed: auth.isLoading 
                              ? null 
                              : () => authProvider.handleGoogleSignIn(context),
                        ),
                        const SizedBox(height: 10),
                        const DividerWithText(text: 'O'),
                        const SizedBox(height: 10),
                        AuthButton(
                          text: 'INICIAR SESIÓN',
                          backgroundColor: AppColors.bgBtnPrimary,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                          onPressed: auth.isLoading
                              ? null
                              : () => Navigator.pushNamed(context, "/login"),
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          text: 'CREAR CUENTA',
                          backgroundColor: AppColors.primary,
                          borderColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: auth.isLoading
                              ? null
                              : () => Navigator.pushNamed(context, '/createAccount'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Políticas de Seguridad",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    if (auth.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Faqpag()),
          );
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Preguntas Frecuentes',
        child: const Icon(Icons.help_outline, color: Colors.white, size: 28),
        elevation: 6,
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}