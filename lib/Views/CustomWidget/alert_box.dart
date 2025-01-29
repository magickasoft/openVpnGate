import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';

class AlertBox extends StatelessWidget {
  final String text;
  const AlertBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,

        children: [
          Container(
            height: 170,
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Alert',style: boldStyle.copyWith(color: Colors.black),),
                Text(text,style: mediumStyle.copyWith(color: Colors.black),),
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: iconBlueColor,
                  child: Text('Ok', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: CircleAvatar(
              backgroundColor: iconBlueColor,
              radius: 25,
              child: Icon(Icons.check,color: Colors.white, size: 25,),
            ),
          )
        ],
      ),
    );
  }
}