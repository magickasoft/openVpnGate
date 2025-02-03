import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vpn_app/Models/vpn_configuration.dart';
import 'package:vpn_app/Models/vpn_status.dart';

class VpnEngine {
  /// Каналы связи с нативным кодом
  static const String _eventChannelVpnStage = "vpnStage";
  static const String _eventChannelVpnStatus = "vpnStatus";
  static const String _methodChannelVpnControl = "vpnControl";

  /// Снимок состояния VPN-подключения
  static Stream<String> vpnStageSnapshot() =>
      EventChannel(_eventChannelVpnStage)
          .receiveBroadcastStream()
          .map((event) => event.toString());

  /// Снимок статуса VPN
  static Stream<VpnStatus> vpnStatusSnapshot() =>
      EventChannel(_eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) {
            try {
              return VpnStatus.fromJson(jsonDecode(event));
            } catch (e) {
              throw Exception("Ошибка парсинга VPN-статуса: $e");
            }
          });

  /// Запуск VPN
  static Future<void> startVpn(VpnConfig vpnConfig) async {
    return MethodChannel(_methodChannelVpnControl).invokeMethod(
      "start",
      {
        "config": vpnConfig.config,
        "country": vpnConfig.country,
        "username": vpnConfig.username,
        "password": vpnConfig.password,
      },
    );
  }

  /// Остановка VPN
  static Future<void> stopVpn() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stop");

  /// Открытие настроек Kill Switch
  static Future<void> openKillSwitch() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("kill_switch");

  /// Обновление состояния VPN
  static Future<void> refreshStage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("refresh");

  /// Получение текущего состояния VPN
  static Future<String?> stage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stage");

  /// Проверка, подключен ли VPN
  static Future<bool> isConnected() async {
    final stageValue = await stage();
    return (stageValue ?? "").toLowerCase() == vpnConnected;
  }

  /// Стадии подключения VPN
  static const String vpnConnected = "connected";
  static const String vpnDisconnected = "disconnected";
  static const String vpnWaitConnection = "wait_connection";
  static const String vpnAuthenticating = "authenticating";
  static const String vpnReconnect = "reconnect";
  static const String vpnNoConnection = "no_connection";
  static const String vpnConnecting = "connecting";
  static const String vpnPrepare = "prepare";
  static const String vpnDenied = "denied";
}
