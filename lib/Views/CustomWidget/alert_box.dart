import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';

class AlertBox extends StatelessWidget {
  final String txt;
  const AlertBox({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              // color: App,
              height: 170,
              width: 280,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(10, 30, 10, 8),
                child: Column(
                  children: [
                    Expanded(child: Padding(
                      padding:  EdgeInsets.only(top: 8.0),
                      child: Text('Alert ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19,color: Colors.black),textAlign: TextAlign.center),
                    )),
                    Expanded(flex:2,child: Padding(
                      padding:  EdgeInsets.only(bottom: 8.0),
                      child: Center(child: Text(txt, style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.center,)),
                    )),
                    Expanded(
                      child: MaterialButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        color: iconBlueColor,
                        child: Text('Okay', style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -20,
                child: CircleAvatar(
                  backgroundColor: iconBlueColor,
                  radius: 25,
                  child: Icon(Icons.check, color: Colors.white, size: 25,),
                )
            ),
          ],
        )
    );
  }
}