import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Controller/home_provider.dart';
import 'package:vpn_app/Views/on_boarding_screen.dart';
import 'package:vpn_app/Views/splash_screen.dart';
import 'package:vpn_app/constant.dart';

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

  Future<void> WheretoGo() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getBool('newUser');

    if (user != null) {
      setState(() {
        newUser = user;
      });
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor, systemNavigationBarColor: primaryColor)
          )
        ),
        home: newUser ? OnBoardingScreen() : SplashScreen(), // Переход в зависимости от newUser
      ),
    );
  }
}
