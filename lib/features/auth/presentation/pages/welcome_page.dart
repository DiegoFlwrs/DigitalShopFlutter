import 'package:digital_shop/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/constants/app_text_styles.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/logo_header.dart';
import 'package:digital_shop/features/auth/presentation/widgets/divider_with_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.bgPrimary,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: Column(
              children: [
                const LogoHeader(),
                _buildWelcomeText(),
                const SizedBox(height: 20),
                const AuthButton(
                  iconPath: 'assets/icons/google.png',
                  text: 'CONTINUAR CON GOOGLE',
                  backgroundColor: AppColors.bgBtnPrimary,
                  textColor: AppColors.black,
                  borderColor: AppColors.primary
                ),
                const SizedBox(height: 16),
                const AuthButton(
                  iconPath: 'assets/icons/facebook.png',
                  text: 'CONTINUAR CON FACEBOOK',
                  backgroundColor: AppColors.bgBtnPrimary,
                  textColor: AppColors.black,
                  borderColor: AppColors.primary,
                ),
                const SizedBox(height: 24),
                const DividerWithText(text: 'O'),
                const SizedBox(height: 24),
                AuthButton(
                  text: 'INICIAR SESIÓN',
                  backgroundColor: AppColors.bgBtnPrimary,
                  textColor: AppColors.black,
                  borderColor: AppColors.primary,
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>LoginPage())
                    );
                  },
                ),
                const SizedBox(height: 16),
                const AuthButton(
                  text: 'CREAR CUENTA',
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  borderColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Text(
          'Haz del estilo una experiencia diaria. En nuestra tienda, cada prenda combina contigo',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}