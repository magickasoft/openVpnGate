import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';

class HomeProvider extends ChangeNotifier {
  var vpnState = VpnEngine.vpnDisconnected;
  void changevpnState(vpnV){
    vpnState=vpnV;
    notifyListeners();
  }
}