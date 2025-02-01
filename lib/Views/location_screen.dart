import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/location_provider.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/CustomWidget/alert_box.dart';
import 'package:vpn_app/Views/CustomWidget/location_card.dart';
import 'package:vpn_app/Views/CustomWidget/vpn_card.dart';
import 'package:vpn_app/Views/constant.dart';

class LocationScreen extends StatefulWidget {
  final List<Vpn> serverList;
  final List<String> countries;
  final List<String> flags;

  LocationScreen({Key? key, required this.serverList, required this.countries, required this.flags}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final String apiUrl = 'https://www.vpngate.net/api/iphone/';
  List<String> countries = [];
  String ? selectedCountry;
  List<Vpn> servers = [];
  List<String> flags = [];
  TextEditingController textcontroller = TextEditingController();
  bool istap = false;
  String ? expandedCountry;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   gettingServers();
    // });
    gettingServers();
  }

  void gettingServers() async {
    final locationController = Provider.of<LocationProvider>(context, listen: false);

    try {

      if (locationController.vpnList.isEmpty || locationController.countryList.isEmpty || locationController.flagList.isEmpty) {
        await locationController.getVpnData();
        await locationController.getCountriesData();
      
        if (mounted) {
          setState(() {
            servers = locationController.vpnList;
            countries = locationController.countryList;
            flags = locationController.flagList;
            print(servers.length);
          });
        }
      } else {
        await locationController.getVpnData();
        await locationController.getCountriesData();
      } 

    } catch (e) {
      print(e);
    }

    // final locationprovider = Provider.of<LocationProvider>(context, listen: false);
    // await locationprovider.getCountriesData();
    // await locationprovider.getVpnData();

    // if (mounted) {
    //   setState(() {
    //     countries = locationprovider.countryList;
    //     flags = locationprovider.flagList;
    //     servers = locationprovider.vpnList;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    // final themeChange = Provider.of<ThemeChanger>(context);

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
      padding: EdgeInsets.only(top: 4.0),
      shrinkWrap: true,
      itemCount: countries.length,
      itemBuilder: (context, index){
        final country = countries[index];
        final flag = flags[index];

        return LocationCard(
          countryName: country,
          flag: flag,
          tap: (istap){
            setState(() {
              if(expandedCountry == country){
                expandedCountry = null;
                istap = false;
                servers = locationProvider.vpnList;
              }
              else {
                expandedCountry = country;
                istap = true;
                servers = serversForSelectedCountry(country);
              }
            });
          },
          server: locationProvider.vpnList.isEmpty 
            ? [CircularProgressIndicator()]
            : servers.asMap().entries.map((MapEntry<int, Vpn> entry) {

              return VpnCard(vpn: entry.value);
            }).toList(),
          isExpanded: country == expandedCountry,
        );
      },
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