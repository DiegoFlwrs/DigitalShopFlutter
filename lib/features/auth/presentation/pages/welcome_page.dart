import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/pages/login_page.dart';

class AuthButton extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  const AuthButton({
    Key? key,
    this.iconPath,
    this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: textColor.withOpacity(0.2),
        onTap: onPressed,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                Image.asset(iconPath!, height: 26, width: 26),
                const SizedBox(width: 14),
              ],
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.white54,
            endIndent: 12,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.white54,
            indent: 12,
          ),
        ),
      ],
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(left: 26, right: 26, top: 36),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // Lottie con sombra glow
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.25),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
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

                // Título con gradiente y sombra
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
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            blurRadius: 7,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Conéctate con la moda que te define y vive la experiencia Digital Shop. Aquí, cada prenda cuenta una historia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                AuthButton(
                  iconPath: 'assets/icons/google.png',
                  text: 'Continuar con Google',
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  textColor: Colors.black87,
                  onPressed: () {
                    // TODO: Acción Google
                  },
                ),

                const SizedBox(height: 18),

                AuthButton(
                  iconPath: 'assets/icons/facebook.png',
                  text: 'Continuar con Facebook',
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  textColor: Colors.black87,
                  onPressed: () {
                    // TODO: Acción Facebook
                  },
                ),

                const SizedBox(height: 10),

                const DividerWithText(text: 'O'),

                const SizedBox(height: 10),

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

                const SizedBox(height: 20),

                AuthButton(
                  text: 'CREAR CUENTA',
                  backgroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () {
                    // TODO: Acción Crear Cuenta
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
