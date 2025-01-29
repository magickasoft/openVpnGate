import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_app/Views/home_screen.dart';
import 'package:vpn_app/Views/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();

  Future.delayed(Duration(milliseconds: 2000), () {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 150,
              width: 150,
              
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('VPN App'.toUpperCase(),
                style: boldStyle,
              ),
            )
          ],
      ),
      )
    );
  }
}