import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/home_provider.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Views/CustomWidget/count_down_timer.dart';

import 'package:vpn_app/Views/CustomWidget/home_card.dart';
import '../constant.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

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
              // SizedBox(height: 10,),
              Expanded(flex: 3, child: VpnConnectButton(context)),
              Expanded(flex: 2, child: ConnectionStatusLabel()),
              Expanded(flex: 1,
                child: CountDownTimer(startTimer: homeProvider.vpnState == VpnEngine.vpnConnected,),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(flex: 5, child: ConnectedVpnDetails(),),              
            ]
        ),
      )




    );
  }

  Widget VpnConnectButton(BuildContext context){
  final homeProvider = Provider.of<HomeProvider>(context);

  return Semantics(
    button: true,
    child: InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: (){
        homeProvider.changevpnState(VpnEngine.vpnConnected);
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

              ///Power Icon
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
    height: 40,
    decoration: BoxDecoration(
      color: iconBlueColor,
      borderRadius: BorderRadius.circular(25),
    ),
    margin: EdgeInsets.symmetric(horizontal: 70, vertical: 50),
    child: Center(
      child: Text('Disconnect',style: boldStyle,)),   
  );
}

  Widget ConnectedVpnDetails(){
  return Column(
    children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: HomeCard(
                title: 'Country',
                subtitle: 'Free',
                icon: Icons.vpn_lock_rounded,
              ),
            ),
            Expanded(
              child: HomeCard(
                title: '100 ms',
                subtitle: 'Ping',
                icon: CupertinoIcons.chart_bar_alt_fill,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: HomeCard(
                title: '0 kbps',
                subtitle: 'Download',
                icon: Icons.arrow_downward_rounded,
              ),
            ),
            Expanded(
              child: HomeCard(
                title: '0 kbps',
                subtitle: 'Upload',
                icon: Icons.arrow_upward_rounded,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
}