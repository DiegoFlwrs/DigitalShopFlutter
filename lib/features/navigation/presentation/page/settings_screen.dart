import 'package:digital_shop/features/auth/presentation/controllers/login_controller.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: const CustomAppBar(),
      // AppBar(
      //   backgroundColor: AppColors.primary,
      //   centerTitle: true,
      //   elevation: 2,
      //   title: const Text(
      //     'Configuración',
      //     style: TextStyle(color: AppColors.white),
      //   ),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("🛠️ Preferencias"),
          _buildCard([
            SwitchListTile(
              value: notificationsEnabled,
              onChanged: (val) => setState(() => notificationsEnabled = val),
              activeColor: AppColors.primary,
              title: const Text("Notificaciones",
                  style: TextStyle(color: AppColors.white)),
            ),
            SwitchListTile(
              value: darkModeEnabled,
              onChanged: (val) => setState(() => darkModeEnabled = val),
              activeColor: AppColors.primary,
              title: const Text("Tema oscuro",
                  style: TextStyle(color: AppColors.white)),
            ),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle("👤 Cuenta"),
          _buildCard([
            _buildTile(
              icon: Icons.lock,
              title: "Cambiar contraseña",
              onTap: () {
                Navigator.pushNamed(context, "/newPassword");
              },
            ),
            _divider(),
            _buildTile(
              icon: Icons.email,
              title: "Cambiar correo electrónico",
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.exit_to_app,
              title: "Cerrar sesión",
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text(
                        '¿Estás seguro de que quieres cerrar sesión?'),
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
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
            ),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle("⚙️ General"),
          _buildCard([
            _buildTile(
              icon: Icons.language,
              title: "Idioma",
              subtitle: "Español",
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.privacy_tip,
              title: "Política de privacidad",
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.info_outline,
              title: "Versión",
              trailing:
                  const Text("v1.0.0", style: TextStyle(color: Colors.white70)),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() => const Divider(color: Colors.white24, height: 0);

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color iconColor = AppColors.primary,
    Color textColor = AppColors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.white70))
          : null,
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
      onTap: onTap,
    );
  }
}
