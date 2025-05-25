import 'package:digital_shop/features/auth/presentation/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/features/auth/presentation/pages/welcome_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_dcalu.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedStartButton(
            text: 'COMENZAR',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
