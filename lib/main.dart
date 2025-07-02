import 'package:digital_shop/core/providers/auth_provider.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/presentation/pages/create_account.dart';
import 'package:digital_shop/features/auth/presentation/pages/login_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/newPasword_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/start.dart';
import 'package:digital_shop/features/auth/presentation/pages/verifyCode_page.dart';
import 'package:digital_shop/features/auth/presentation/pages/welcome_page.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:digital_shop/features/navigation/presentation/page/home_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/payment/payment_failure_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/payment/payment_success_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/product_detail_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/statistics/statistics_screen.dart';
import 'package:digital_shop/features/search/page/Search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final apiService = ApiService();
  final data = NavegationRemoteDatasource(apiService);
  final repository = NavegationRepositoryImpl(data);
  Get.put(NavegationUseCase(repository));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      initialRoute: '/start',
      routes: {
        // '/splash': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/createAccount': (context) => CreateAccount(),
        '/search': (context) => SearchPage(),
        '/home': (context) => const HomeScreen(),
        '/verifyCode': (context) => VerifyCode(),
        '/newPassword': (context) => NewPassword(),
        '/detail': (context) => const ProductDetailScreen(),
        '/statistics': (context) => const StatisticsPage(),
        '/payment-success': (context) => const PaymentSuccessScreen(),
        '/payment-failure': (context) => const PaymentFailureScreen(),
      },
      home: const StartScreen(), // Cambia StartScreen por SplashScreen
    );
  }
}
