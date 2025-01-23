
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_app/Views/CustomWidget/simple_button.dart';
import 'package:vpn_app/Views/splash_screen.dart';
import 'package:vpn_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/splash_screen_content.dart';

class OnBoardingScreen extends StatefulWidget {
    const OnBoardingScreen({ super.key });

    @override
    _OnBoardingScreen createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: PageView.builder(
              itemCount: contents.length,
              controller: _pageController,
              onPageChanged: (int index) {
                if(index > 0) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                    return;
                  }
              },
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.all(30.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SvgPicture.asset(
                          contents[index].image,
                          fit: BoxFit.fill,
                        ).animate().fade().slideY(curve: Curves.easeIn),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          contents[index].title,
                          style: boldStyle,
                          textAlign: TextAlign.center,
                        ).animate().fade().slideX(curve: Curves.easeInCirc),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        contents[index].description,
                        style: mediumStyle,
                        textAlign: TextAlign.center,
                      ).animate().fade().slideX(curve: Curves.easeInOutBack),
                    ),
                  ],
                )
                );
              },
            ),
          ),
          //Dots
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 2,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                )
              ),

            ),
          ),
          // buttons
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                    child: SimpleButton(text: 'Next', tap: ()async {
                      if (currentIndex == contents.length - 1) {
                        var sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setBool('newUser', true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen(),
                          ),
                        );
                      }
                      _pageController?.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceOut,
                      );
                    }),      
                    ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20,top: 5),
                    child: InkWell(
                      onTap:() async {
                        var sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setBool('newUser', true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen(),
                          ),
                        );
                      },
                      child: Text('Skip', style: boldStyle.copyWith(fontSize: 16)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
          colors: currentIndex == index
            ? [blue, gradientblue]
            : [Colors.white, Colors.white],
        )
      ),
    );
  }
}
