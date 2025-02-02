import 'package:flutter/cupertino.dart';
import 'package:vpn_app/Controllers/api/apis.dart';
import 'package:vpn_app/Controllers/pref.dart';
import 'package:vpn_app/Models/vpn.dart';

class LocationProvider extends ChangeNotifier {
  List<Vpn> _vpnList = Pref.vpnList;
  List<Vpn> get vpnList => _vpnList;
  List<String> _countryList = Pref.getStoredCountries();
  List<String> _flagList = Pref.getStoredCountryFlags();
  List<String> get countryList => _countryList;
  List<String> get flagList => _flagList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<void> getVpnDataForFirstLoad() async {
  //   _isLoading = true;
  //   _vpnList.clear();
  //   _vpnList = await Api.getVpnServers();
  //   _isLoading = false;
  //   notifyListeners();
  // }

  Future<void> getVpnData() async {
    _isLoading = true;
    _vpnList.clear();
    _vpnList = await Api.getVpnServers();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCountriesData()async{
    _isLoading = true;
    _countryList.clear();
    _flagList.clear();
    _countryList=await Api.getCountries();
    _flagList =await Api.getCountriesFlags();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getVpn() async {
    _isLoading = true;
     notifyListeners(); // Notify listeners that isLoading has changed
    _vpnList.clear();
    _vpnList = await Api.getVpnServers();
    _countryList=await Api.getCountries();
    _flagList =await Api.getCountriesFlags();
    _isLoading = false;
    notifyListeners(); // Notify listeners that isLoading has changed
  }
}
