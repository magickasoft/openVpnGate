import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_app/Controllers/pref.dart';
import 'package:vpn_app/Models/ip_details.dart';
import 'package:vpn_app/Models/vpn.dart';

class Api {

  static Future<List<Vpn>> getVpnServers() async {
    final List<Vpn> vpnList = [];

    try{
      final res = await http.get(Uri.parse('https://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
        
      final header = list[0];

      for(int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for(int j = 0; j < header.length; ++j) {
          tempJson.addAll({(header[j].toString()): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }
    } catch(e){
      log('\ngetVpnServers: $e');
    }

    vpnList.shuffle();

    if (vpnList.isNotEmpty) {
      Pref.vpnList = vpnList;
    }

    return vpnList;
  }

  static Future<List<String>> getCountriesFlags() async {
    List<String> flags = [];
    try {
      final response = await http.get(Uri.parse('https://www.vpngate.net/api/iphone/'));

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
        await Pref.storeCountryFlags(flags);

      } else {
        print(
          'Error: Unable to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return flags;
  }

  static Future<List<String>> getCountries() async {
    List<String> countries = [];
    try {
      final response = await http.get(Uri.parse('https://www.vpngate.net/api/iphone/'));

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
        await Pref.storeCountries(countries);

      } else {
        print('Error: Unable to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return countries;
  }

  static Future<NetworkDetails> getIPDetails({ required NetworkDetails ipData }) async {
    var ipdata;
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(response.body);
      ipdata = NetworkDetails.fromJson(data);
    } catch (e) {
      print('\ngetIPDetailsError: $e');
    }
    return ipdata;
  }
}