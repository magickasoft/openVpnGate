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

  static Future<List<String>> getCountries() async {
  /// Fetches a list of unique country names from the VPN Gate API.

    List<String> countries = [];
    try {
      final response = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));

      if (response.statusCode == 200) {

        List<String> lines = response.body.split("\n");
        print(lines);

        Set<String> uniqueCountries = {};

        for (int i = 2; i < lines.length; i++) {
          List<String> serverInfo = lines[i].split(",");

          if (serverInfo.length > 7) {
            uniqueCountries.add(serverInfo[5]);
          }
        }

        countries = uniqueCountries.toList();
        print(countries);
      } else {
        print('Error: Unable to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return countries;
  }

  static Future<List<String>> getCountriesFlags() async {
  /// Fetches a list of unique country names from the VPN Gate API.

    List<String> flags = [];
    try {
      final response = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));

      if (response.statusCode == 200) {

        List<String> lines = response.body.split("\n");
        print(lines);

        Set<String> uniqueCountries = {};

        for (int i = 2; i < lines.length; i++) {
          List<String> serverInfo = lines[i].split(",");

          if (serverInfo.length > 6) {
            uniqueCountries.add(serverInfo[6]);
          }
        }

        flags = uniqueCountries.toList();
        print(flags);
      } else {
        print('Error: Unable to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return flags;
  }
}