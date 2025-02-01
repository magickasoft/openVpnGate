import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_app/Models/vpn.dart';

class Pref {
  static late Box box;
  static Future<void>initializeHive() async {
    await Hive.initFlutter();
    box = await Hive.openBox('data');
  }

  static Vpn get vpn => Vpn.fromJson(jsonDecode(box.get('vpn') ?? '{}'));
  static set vpn(Vpn v) => box.put('vpn', jsonEncode(v));
  
}