import 'package:digital_shop/features/auth/presentation/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _isCheckingAuth = false;

  Future<void> _navigateBasedOnAuth() async {
    if (_isCheckingAuth) return;
    _isCheckingAuth = true;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenAccess');
    final isLoggedIn = token != null && token.isNotEmpty;

    if (!mounted) {
      _isCheckingAuth = false;
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? '/search' : '/welcome',
    );
    _isCheckingAuth = false;
  }

  @override
  void initState() {
    super.initState();
    // _navigateBasedOnAuth(); // Opcional: navegación automática al iniciar
  }

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
          AnimatedStartButton(
            text: 'COMENZAR',
            onPressed: _navigateBasedOnAuth, // Usamos la misma función
          ),
        ],
      ),
    );
  }
}