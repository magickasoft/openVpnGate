import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controllers/pref.dart';
import 'package:vpn_app/Controllers/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Models/vpn_configuration.dart';
import 'package:vpn_app/Views/constant.dart';

enum VpnState { disconnected, connected, connecting }


class VpnProvider extends ChangeNotifier {
  Vpn vpn = Pref.vpn;
  var vpnState = VpnEngine.vpnDisconnected;
  String selectedVpnId = '';
  void changeVpnState(vpnV){
    vpnState=vpnV;
    notifyListeners();
  }
  void setSelectedVpn(String vpnId) {
    selectedVpnId = vpnId;
    notifyListeners() ;
  }

///For Connection
   connectToVpn(context) async {
    if (vpn.openVPNConfigDataBase64.isEmpty) {
      return  ;
    }

   else  if (vpnState == VpnEngine.vpnDisconnected) {

      final data = Base64Decoder().convert(vpn.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);


      await VpnEngine.startVpn(vpnConfig);
      notifyListeners();

    }

    else if (vpnState == VpnEngine.vpnDenied)  {

      final data = Base64Decoder().convert(vpn.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);


      await VpnEngine.startVpn(vpnConfig);
      notifyListeners();

    }
    else {
      VpnEngine.stopVpn();
      notifyListeners();

    }
  }


///Get Box Shadow Gradient Color
  Color get getBoxShadowGradientColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return lightGradientBlue.withOpacity(0.08);

      case VpnEngine.vpnConnected:
        return gradientGreen.withOpacity(0.09);

      default:
        return gradientYellow.withOpacity(0.09);
    }
  }
  /// for getting Box shadow color
 Color get getBoxShadowColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return blue;

      case VpnEngine.vpnConnected:
        return green;

      default:
        return yellow;
    }
  }
    ///Outer gradient Color
  List<Color> get getGradientDarkColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [

          lightBlue.withOpacity(.04),
          lightGradientBlue.withOpacity(.03),

        ];
      case VpnEngine.vpnConnected:
        return [

          gradientGreen.withOpacity(.03),
          gradientGreen.withOpacity(.03),
        ];

      default:
        return [

          gradientYellow.withOpacity(.03),
          gradientYellow.withOpacity(.03),
        ];


    }
  }
  List<Color> get getGradientWhiteColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [

          lightBlue.withOpacity(.08),
          lightGradientBlue.withOpacity(.08),

        ];
      case VpnEngine.vpnConnected:
        return [

          gradientGreen.withOpacity(.08),
          gradientGreen.withOpacity(.08),
        ];

      default:
        return [

          gradientYellow.withOpacity(.08),
          gradientYellow.withOpacity(.08),
        ];


    }
  }
///Button Gradient Color
  List<Color> get getButtonColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return [

          blue,
          gradientBlue,
        ];

      case VpnEngine.vpnConnected:
        return [

         green,
          gradientGreen,
          gradientGreen
        ];

      default:
        return [

          yellow,
          gradientYellow,
          gradientYellow
        ];
    }
  }

  /// vpn button text
  String get getButtonText {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return '  Disconnect   ';

      default:
        return '  Connecting...';
    }
  }


}