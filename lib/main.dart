import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Views/on_boarding_screen.dart';
import 'package:vpn_app/Views/splash_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
     DeviceOrientation.portraitDown]).then((_) {
          runApp(const MyApp());
        });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool newUser = false;

  WheretoGo() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getBool('newUser');

    print(user);

    if (user != null) {
      if (user) {
        setState(() {
          newUser = false;
        });
      } else {
        setState(() {
          newUser = false;
        });
      }
    } else {
      setState(() {
        newUser = false;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    WheretoGo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: newUser ? OnBoardingScreen() : SplashScreen(),
    );
  }
}