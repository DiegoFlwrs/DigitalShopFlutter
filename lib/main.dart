import 'package:digital_shop/features/auth/presentation/pages/create_account.dart';
import 'package:digital_shop/features/auth/presentation/pages/login_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/newPasword_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/start.dart';
import 'package:digital_shop/features/auth/presentation/pages/verifyCode_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/welcome_page.dart';
import 'package:digital_shop/features/navigation/presentation/page/home_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/product_detail_screen.dart';
import 'package:digital_shop/features/search/page/Search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) =>  LoginPage(),
        '/createAccount': (context) => CreateAccount(),
        '/search': (context) => SearchPage(),
        '/home': (context) => const HomeScreen(), 
        '/verifyCode': (context) => VerifyCode(),
        '/newPassword': (context) => NewPassword(),
        '/detail': (context) => const ProductDetailScreen(),
        '/homeScreen': (context) => const HomeScreen(),
      },
      home: const StartScreen(), 
    );
  }
}
