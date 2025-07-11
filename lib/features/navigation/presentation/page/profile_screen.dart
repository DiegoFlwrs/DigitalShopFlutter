import 'package:digital_shop/features/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Opciones de Cuenta",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),

          // Botón para ver perfil del usuario
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Mi Perfil"),
            onTap: () => Navigator.pushNamed(context, "/myporfile"),
          ),

          // Botón para ver lista de pedidos
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Mis Pedidos"),
            onTap: () => Navigator.pushNamed(context, "/orders"),
          ),

          // Botón para ver historial de pagos
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Historial de Pagos"),
            onTap: () => Navigator.pushNamed(context, "/payment_history"),
          ),

          const Divider(height: 32),

          const Text(
            "Ajustes y Otros",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),

          // Botón para configuración del usuario
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configuración"),
            onTap: () => Navigator.pushNamed(context, "/settings"),
          ),

          // Botón para centro de ayuda
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Centro de Ayuda"),
            onTap: () => Navigator.pushNamed(context, "/help_center"),
          ),

          // Botón para ver estadísticas del usuario
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Ver Estadísticas"),
            onTap: () => Navigator.pushNamed(context, "/statistics"),
          ),

          // Botón para cerrar sesión
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar sesión"),
            textColor: Colors.red.shade800,
            iconColor: Colors.red.shade800,
            onTap: () async {
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
    );
  }
}
