import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';

class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final image;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
            decoration: 
            image !=null 
            ? BoxDecoration( gradient: LinearGradient(
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                  colors: [
                    blue,
                    gradientblue,
                  ]),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                  ),              
            ):
            BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                  colors: [
                    blue,
                    gradientblue,
                  ]),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                size: 26, color: Colors.white,),
                  ),
              ),
              Text(title,
                style:btnStyle.copyWith(fontSize: 13.5,color: Colors.white),

              ),
              SizedBox(height: 2,),
              Text(subtitle,
                style: greyStyle.copyWith(color: greytext),
              )
        ],
      ),
    );      
  }
}