class Vpn {
  Vpn({
    required this.HostName,
    required this.IP,
    required this.Score,
    required this.Ping,
    required this.Speed,
    required this.CountryLong,
    required this.CountryShort,
    required this.NumVpnSessions,
    required this.Uptime,
    required this.TotalUsers,
    required this.TotalTraffic,
    required this.LogType,
    required this.Operator,
    required this.Message,
    required this.OpenVPNConfigDataBase64,
  });

  late final String HostName;
  late final String IP;
  late final int Score;
  late final int Ping;
  late final int Speed;
  late final String CountryLong;
  late final String CountryShort;
  late final int NumVpnSessions;
  late final int Uptime;
  late final int TotalUsers;
  late final int TotalTraffic;
  late final String LogType;
  late final String Operator;
  late final String Message;
  late final String OpenVPNConfigDataBase64;

  Vpn.fromJson(Map<String, dynamic> json) {
    HostName = json['HostName'] ?? '';
    IP = json['IP'] ?? '';
    Score = _toInt(json['Score']);
    Ping = _toInt(json['Ping']);
    Speed = _toInt(json['Speed']);
    CountryLong = json['CountryLong'] ?? '';
    CountryShort = json['CountryShort'] ?? '';
    NumVpnSessions = _toInt(json['NumVpnSessions']);
    Uptime = _toInt(json['Uptime']);
    TotalUsers = _toInt(json['TotalUsers']);
    TotalTraffic = _toInt(json['TotalTraffic']);
    LogType = json['LogType'] ?? '';
    Operator = json['Operator'] ?? '';
    Message = json['Message'] ?? '';
    OpenVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'HostName': HostName,
      'IP': IP,
      'Score': Score,
      'Ping': Ping,
      'Speed': Speed,
      'CountryLong': CountryLong,
      'CountryShort': CountryShort,
      'NumVpnSessions': NumVpnSessions,
      'Uptime': Uptime,
      'TotalUsers': TotalUsers,
      'TotalTraffic': TotalTraffic,
      'LogType': LogType,
      'Operator': Operator,
      'Message': Message,
      'OpenVPN_ConfigData_Base64': OpenVPNConfigDataBase64,
    };
  }

  /// Безопасное преобразование в `int`
  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
