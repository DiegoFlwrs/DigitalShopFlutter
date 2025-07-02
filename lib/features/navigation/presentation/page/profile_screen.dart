import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/controllers/login_controller.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "PANEL ADMIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            AuthButton(
              backgroundColor: AppColors.white,
              textColor: AppColors.black,
              borderColor: AppColors.grey500,
              text: "Ver Estadísticas",
              onPressed: () {
                Navigator.pushNamed(context, "/statistics");
              },
            ),
            const SizedBox(height: 10),
            AuthButton(
              backgroundColor: Colors.red.shade100,
              textColor: Colors.red.shade800,
              borderColor: Colors.red.shade200,
              text: "Cerrar sesión",
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Sí, cerrar sesión'),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  await LoginController.logout(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}