import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Controller/helpers/pref.dart';
import 'package:vpn_app/Controller/home_provider.dart';
import 'package:vpn_app/Controller/location_provider.dart';
import 'package:vpn_app/Views/on_boarding_screen.dart';
import 'package:vpn_app/Views/splash_screen.dart';
import 'package:vpn_app/Views/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.initializeHive();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
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
        ChangeNotifierProvider<LocationProvider>(create: (context) => LocationProvider()),
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
