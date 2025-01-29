import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Views/CustomWidget/alert_box.dart';
import 'package:vpn_app/Views/constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({ super.key });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    

    super.initState();
    getData();
  }

  getData()async{
    await Api.getVpnServers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Vpn Servers', style: boldStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
          elevation: 0,
      ),
      body: Container(
        child: loadingWidget(),
      ),
    );
    }

    loadingWidget(){
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/animation/load.json',
              width: 220,
            ),
            Text('Loading Vpns', style: boldStyle,)
          ],
        ),
      );
  }

  VPNNotFound(){
    return AlertBox(text: 'Sorry. VPNs Not Found! 😕',);
  }
}