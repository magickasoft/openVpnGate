import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Controller/location_provider.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/CustomWidget/alert_box.dart';
import 'package:vpn_app/Views/CustomWidget/location_card.dart';
import 'package:vpn_app/Views/constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({ super.key });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  List<String> flags = [];
  List<String> countries = [];
  List<Vpn> servers = [];
  String ? selectedCountry;
  String ? expandedCountry;

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
    await locationprovider.getVpnData();

    if (mounted) {
      setState(() {
        countries = locationprovider.countryList;
        flags = locationprovider.flagList;
        servers = locationprovider.vpnList;
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
          : locationProvider.countryList.isEmpty
              ? vpnNotFound()
              : serverData(locationProvider),
    );
  }

  serverData(LocationProvider locationProvider) {
    return ListView.builder(
      itemBuilder: (con,index){
        return LocationCard(
          countryName: locationProvider.countryList[index],
          flag: locationProvider.flagList[index],
          tap: (istap){
            setState(() {
              if(expandedCountry == locationProvider.countryList[index]){
                expandedCountry = null;
                istap = false;
                servers = locationProvider.vpnList;
              }
              else {
                expandedCountry = locationProvider.countryList[index];
                istap = true;
                servers = serversForSelectedCountry(locationProvider.countryList[index]);
              }
            });
          },
          server: locationProvider.vpnList.isEmpty 
            ? [CircularProgressIndicator()]
            : servers.asMap().entries.map((MapEntry<int, Vpn> entry) {
              return Container();
            }).toList(),
          isExpanded: locationProvider.countryList[index] == expandedCountry,
        );
    },
    itemCount: 7);
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

  List<Vpn> serversForSelectedCountry(String country){
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    List<Vpn> data = locationProvider.vpnList;
    List<Vpn> myservers = data.where((server) => server.countryLong.toLowerCase() == country.toLowerCase()).toList();

    return myservers;
  }
}