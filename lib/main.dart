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
import 'package:digital_shop/features/navigation/presentation/controllers/historial_controller.dart';
import 'package:digital_shop/features/navigation/presentation/page/home_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/payment/payment_failure_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/payment/payment_success_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/porfile/porfile_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/product_detail_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/statistics/statistics_screen.dart';
import 'package:digital_shop/features/search/page/Search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:digital_shop/features/navigation/presentation/page/orders_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/payments_history_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/settings_screen.dart';
import 'package:digital_shop/features/navigation/presentation/page/help_center_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  final data = NavegationRemoteDatasource(apiService);
  final repository = NavegationRepositoryImpl(data);
  

  final useCase = NavegationUseCase(repository);

  Get.put(NavegationUseCase(repository));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => OrderHistoryController(useCase: useCase),
        ),
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
        '/welcome': (context) => const WelcomePage(),
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
        '/myporfile': (context) => MyProfilePage(),
        '/orders': (context) => const OrdersScreen(),
        '/payment_history': (context) => const PaymentsHistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help_center': (context) => const HelpCenterScreen(),
      },
      home: const StartScreen(),
    );
  }
}
