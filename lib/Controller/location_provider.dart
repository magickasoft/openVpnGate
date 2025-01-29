import 'package:flutter/cupertino.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Models/vpn.dart';

class LocationProvider extends ChangeNotifier {
  List<Vpn> _vpnList = [];
  bool _isLoading = false;

  List<Vpn> get vpnList => _vpnList;
  bool get isLoading => _isLoading;

  List<String> _countryList = [];
  List<String> _flagList = [];

  List<String> get countryList => _countryList;
  List<String> get flagList => _flagList;

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
