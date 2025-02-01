class NetworkDetails {
  late final String country;
  late final String regionName;
  late final String city;
  late final String zip;
  late final String timezone;
  late final String isp;
  late final String as;
  late final String query;

  NetworkDetails({
    required this.country,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });
  
  NetworkDetails.fromJson(Map<String, dynamic> json){
    country = json['country'] ?? '';
    regionName = json['regionName'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '';
    timezone = json['timezone'] ?? ' - - - -';
    isp = json['isp'] ?? 'Unknown';
    as = json['as'] ?? 'Unknown';
    query = json['query'] ?? 'Not available';
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['status'] = status;
  //   _data['country'] = country;
  //   _data['countryCode'] = countryCode;
  //   _data['region'] = region;
  //   _data['regionName'] = regionName;
  //   _data['city'] = city;
  //   _data['zip'] = zip;
  //   _data['lat'] = lat;
  //   _data['lon'] = lon;
  //   _data['timezone'] = timezone;
  //   _data['isp'] = isp;
  //   _data['org'] = org;
  //   _data['as'] = as;
  //   _data['query'] = query;
  //   return _data;
  // }
}