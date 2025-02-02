import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_app/Views/Screens/home_screen.dart';
import 'package:vpn_app/Views/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex:4,child: Container()),
            Expanded(
              flex: 5,
              child: Padding(
                padding:  EdgeInsets.only(top: 20.0,bottom: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex:2,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',).animate().fade().shake()
                    ),
                    // SizedBox(height: 20.h,),
                    Expanded(child: Padding(
                      padding:  EdgeInsets.only(top: 15.0),
                      child: Text(' SwiftShield '.toUpperCase(),
                        style: logoText.copyWith(color: white,fontSize: 25),).animate().fade().slideX(),
                    )),
                    // Expanded(child: Text('Secure. Fast. Stable  ',style: grayTextStyle.copyWith(fontSize: 16,color: halfWhite),).animate().fade().slideY()),

                  ],),
              ),
            ),
           Expanded(flex:3,child: Center(
              child: SizedBox(height: 50,width:50,child: CircularProgressIndicator(color: iconBlueColor,),),
            )),

          ],


        )
    );
  }

}