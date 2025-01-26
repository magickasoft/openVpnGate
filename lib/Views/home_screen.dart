import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('VPN App'.toUpperCase(),
        style: logoText,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu,
                color: Colors.white, size: 28),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(CupertinoIcons.globe,
                color: Colors.white, size: 28),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: 
          Column(
            children: [
              SizedBox(height: 10,),
              VpnContentButton(),
              ConnectionStatusLabel(),
            ]
        ),
      )
    );
  }
}

Widget VpnContentButton(){
  return Semantics(
    button: true,
    child: InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: (){

      },
      child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
          colors: [
            lightblue.withOpacity(0.08),
            lightGradientblue.withOpacity(0.08),
          ]),
          boxShadow: [
            BoxShadow(
              color: lightGradientblue.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: FractionalOffset.topRight,
            end: FractionalOffset.bottomLeft,
            colors: [
              lightblue.withOpacity(0.08),
              lightGradientblue.withOpacity(0.08),
            ]),
            boxShadow: [
              BoxShadow(
                color: lightGradientblue.withOpacity(0.08),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(shape: BoxShape.circle, 
          gradient: LinearGradient(
            begin: FractionalOffset.topRight,
            end: FractionalOffset.bottomLeft,
            colors: [
              blue,
              gradientblue
            ]),
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        ),  
        child: Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle, color: white),
          height: 120, 
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.power_settings_new,
                size: 28,
                color: iconBlueColor,
              ),
              SizedBox(height: 4,),
              Text('Tap to Connect',
                style: greyStyle,
              )
            ],
          ),
      ),
    ),
  ),
  ),
  ),
  );
}

Widget ConnectionStatusLabel(){
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: iconBlueColor,
      borderRadius: BorderRadius.circular(25),
    ),
    margin: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
    child: Center(
      child: Text('Disconnect',style: boldStyle,)),   
  );
}