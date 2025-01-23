
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
            child: PageView.builder(
              itemCount: contents.length,
              controller: _pageController,
              onPageChanged: (int index) {
                if(index > 0) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                    return null;
                  }
              },
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.all(30.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: SvgPicture.asset(
                        contents[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          contents[index].title,
                          style: boldStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        contents[index].description,
                        style: mediumStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                );
              },
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
}
