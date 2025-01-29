import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';

import 'package:vpn_app/Views/constant.dart';

class HomeProvider extends ChangeNotifier {
  var vpnState = VpnEngine.vpnDisconnected;
  Vpn? vpn;

  void changevpnState(vpnV){
    vpnState=vpnV;
    notifyListeners();
  }

  String get getButtonText{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return "Tap to connect";
      case VpnEngine.vpnConnected:
        return "Disconnect";
      default:
        return "Connecting...";
    }
  }

  Color get getBoxShadowColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return blue;
      case VpnEngine.vpnConnected:
        return green;
      default:
        return yellow;
    }
  } 

  List<Color> get getButtonColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [blue, gradientblue];
      case VpnEngine.vpnConnected:
        return [green, gradientgreen, gradientgreen];
      default:
        return [yellow, gradientyellow, gradientyellow];
    }
  } 

  List<Color> get getGradientDarkColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [
          lightblue.withOpacity(.04),
          lightGradientblue.withOpacity(.03),
        ];
      case VpnEngine.vpnConnected:
        return [
          gradientgreen.withOpacity(.03),
          gradientgreen.withOpacity(.03),
        ];
      default:
        return [
          gradientyellow.withOpacity(.03),
          gradientyellow.withOpacity(.03)
        ];
    }
  }

  List<Color> get getGradientWhiteColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [
          lightblue.withOpacity(.08),
          lightGradientblue.withOpacity(.08),
        ];
      case VpnEngine.vpnConnected:
        return [
          gradientgreen.withOpacity(.08),
          gradientgreen.withOpacity(.08),
        ];
      default:
        return [
          gradientyellow.withOpacity(.08),
          gradientyellow.withOpacity(.08)
        ];
    }
  }
}