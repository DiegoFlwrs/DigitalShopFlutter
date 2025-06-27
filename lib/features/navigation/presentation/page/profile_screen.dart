import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      // Text('Profile')
      Padding(
        padding: EdgeInsets.all(20),
        child: 
        Column(
          children: [
            Text("PANEL ADMIN", 
            style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            AuthButton(
              backgroundColor: AppColors.white, 
              textColor: AppColors.black, 
              borderColor: AppColors.grey500,
              text: "Ver Estadísticas",
              onPressed: () {
                Navigator.pushNamed(context,"/statistics");
              },
              ),
          ],
        ))
    );
  }
}
