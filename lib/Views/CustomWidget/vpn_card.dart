import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/helpers/pref.dart';
import 'package:vpn_app/Controller/home_provider.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/constant.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(        
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        child: InkWell(
          onTap: (){
            homeProvider.vpn=vpn;
            Pref.vpn = vpn;
        
            Navigator.pop(context);
            if (homeProvider.vpnState == VpnEngine.vpnConnected) {
              VpnEngine.stopVpn();
              Future.delayed(
                const Duration(seconds: 2), () = homeProvider.connectToVpn(context),);

            } else {
              homeProvider.connectToVpn(context);
            }
          },
          child: ListTile(
            leading: Container(
              height: 30,
              width: 38,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/flags/${vpn.countryShort.toLowerCase()}.png'),
                  fit: BoxFit.fill,
                ),
              )
            ),
            title: Text(vpn.countryLong, style: boldStyle.copyWith(
              color: Colors.white, fontSize: 15,
            ),),
            subtitle: Row(
              children: [
                Text(_formatBytes(vpn.speed, 1), style: mediumStyle.copyWith(color: greytext),),
                SizedBox(width: 4,),
                Icon(Icons.speed, color: iconBlueColor, size: 20,)
              ],
            ),
          ),
        ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["Bps", " Kbps", " Mbps", " Gbps", " Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}