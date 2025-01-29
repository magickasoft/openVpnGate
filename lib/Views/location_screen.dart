import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Controller/location_provider.dart';
import 'package:vpn_app/Views/CustomWidget/alert_box.dart';
import 'package:vpn_app/Views/constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({ super.key });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  List<String> flags = [];
  List<String> countries = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gettingServers();
    });
  }

  void gettingServers()async{
    final locationprovider = Provider.of<LocationProvider>(context, listen: false);
    await locationprovider.getCountriesData();

    if (mounted) {
      setState(() {
        countries = locationprovider.countryList;
        flags = locationprovider.flagList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

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
      body: locationProvider.isLoading
          ? loadingWidget()
          // : locationProvider.vpnList.isEmpty
          : locationProvider.countryList.isEmpty
              ? vpnNotFound()
              : serverData(locationProvider),
    );
  }

  serverData(LocationProvider locationProvider) {
    return ListView.builder(
      itemBuilder: (con,index){
        return Text(
          locationProvider.countryList[index],
          style: TextStyle(color: Colors.white),
        );
    },
    itemCount: locationProvider.countryList.length,);
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

  vpnNotFound(){
    return AlertBox(text: 'Sorry. VPNs Not Found! 😕',);
  }
}