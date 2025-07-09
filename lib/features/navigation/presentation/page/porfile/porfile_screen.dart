import 'package:flutter/material.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/variants_controller.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/navigation/data/models/profile/profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final VariantsController _controller = VariantsController(
    NavegationUseCase(
      NavegationRepositoryImpl(
        NavegationRemoteDatasource(ApiService()),
      ),
    ),
  );

  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Obtener el userId como entero
  int? id = prefs.getInt('userId');
  if (id != null) {
    print("userId recuperado: $id");
  } else {
    print("No se encontró el userId.");
  }
  
  // Actualiza el estado para que la UI se redibuje
  setState(() {
    userId = id?.toString();  // Convierte a String si es necesario
  });
}

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        appBar: CustomAppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ProfiResponse?>(
          future: _controller.getProfileUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No se pudo cargar el perfil.'));
            } else {
              ProfiResponse? profile = snapshot.data;

              return ListView(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        IconButton(
                          onPressed: () {
                            // Acción para cambiar la foto
                          },
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          iconSize: 30,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile?.name ?? 'Nombre no disponible',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile?.email ?? 'Correo no disponible',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tarjeta de detalles de perfil
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nombre Completo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            profile?.name ?? 'Nombre no disponible',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const Divider(),

                          const Text(
                            "Correo Electrónico",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            profile?.email ?? 'Correo no disponible',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const Divider(),

                          const Text(
                            "Teléfono",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "+51 948154640", // Cambia si tienes el teléfono real
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/newPassword");
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cambiar Contraseña'),
                  ),
                  const SizedBox(height: 16),

                  const Divider(),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Ajustes de la Cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text('Cambiar dirección de envío'),
                    onTap: () {
                      // Acción para cambiar dirección
                    },
                  ),
                  ListTile(
                    title: const Text('Cerrar sesión'),
                    onTap: () {
                      // Acción para cerrar sesión
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
