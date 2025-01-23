
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_app/constant.dart';

import '../Models/splash_screen_content.dart';

class OnBoardingScreen extends StatefulWidget {
    const OnBoardingScreen({ super.key });

    @override
    _OnBoardingScreen createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      contents[index].image,
                      fit: BoxFit.fill,
                      placeholderBuilder: (context) => CircularProgressIndicator(),
                      // Добавьте обработку ошибок
                      errorBuilder: (context, error, stackTrace) {
                        print("Error loading image: ${contents[index].image}");
                        return Text("Error loading image");
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
