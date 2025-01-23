// import 'package:flutter/material.dart';
// import 'package:vpn_app/constant.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vpn_app/Views/home_screen.dart';
import 'package:vpn_app/constant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // Переход на главный экран или экран авторизации
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Замените MainScreen на ваш главный экран
        ),
      );
    });

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Логотип приложения
            Image.asset(
              'assets/logo.png', // Укажите путь к логотипу
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Текстовый заголовок или слоган
            Text(
              'VPN App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Индикатор загрузки
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

