import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/api/apis.dart';
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
    );
  }
}