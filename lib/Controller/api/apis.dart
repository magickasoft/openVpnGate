import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_app/Models/vpn.dart';

class Api {

  static Future<List<Vpn>> getVpnServers() async {
    final List<Vpn> vpnList = [];

    try{
      final response = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));
      final csvString = response.body.split("#")[1].replaceAll('*', '');
      List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);
        
      final header = csvList[0];
      Map<String, dynamic> tempJson = {};

      for(int i=1; i<header.length; ++i) {
        for(int j=0; j<header.length; ++j) {
          tempJson.addAll({(header[j].toString()): csvList[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }
      log(vpnList.first.hostName);
    }
    catch(e){
      log(e.toString());
    }

    return vpnList;
  }
}