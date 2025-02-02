import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Controllers/pref.dart';
import 'package:vpn_app/Controllers/home_provider.dart';
import 'package:vpn_app/Controllers/location_provider.dart';
import 'package:vpn_app/Views/Screens/on_boarding_screen.dart';
import 'package:vpn_app/Views/Screens/splash_screen.dart';
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

  @override
  void initState() {
    super.initState();
    WheretoGo();
  }

  Check() async{
    await  WheretoGo();
  }

  Future<void> WheretoGo() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getBool('newUser');
    print(user);
    if (user != null) {
      if (user) {
        setState(() {
          newUser = true;
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VpnProvider>(create: (context) => VpnProvider()),
        ChangeNotifierProvider<LocationProvider>(create: (context) => LocationProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: iconBlueColor,
              ),
              scaffoldBackgroundColor: primaryColor,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor, systemNavigationBarColor: primaryColor, )
              ),
              brightness: Brightness.light,
              unselectedWidgetColor: Colors.white,
              // toggleableActiveColor: Colors.yellow,
            ),
            debugShowCheckedModeBanner: false,
            home: newUser ? SplashScreen() : OnBoardingScreen(),
          );
        }
      ),
    );
  }
}
