import 'package:flutter/cupertino.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Controller/helpers/pref.dart';
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

  Future<void> getVpnDataForFirstLoad() async {
    _isLoading = true;
    _vpnList.clear();
    _vpnList = await Api.getVpnServers();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getVpnData() async {
    _isLoading = true;
    _vpnList.clear();
    _vpnList = await Api.getVpnServers();
    _isLoading = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getCountriesData() async {
    _setLoading(true);

    _countryList.clear();
    _flagList.clear();

    final results = await Future.wait([
      Api.getCountries(),
      Api.getCountriesFlags(),
    ]);

    _countryList.addAll(results[0]);
    _flagList.addAll(results[1]);

    _setLoading(false);
  }
}
