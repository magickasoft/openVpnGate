import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/api/apis.dart';
import 'package:vpn_app/Models/network_details.dart';
import 'package:vpn_app/Views/CustomWidget/ip_detail_card.dart';
import 'package:vpn_app/Views/constant.dart';

class IpDetailScreen extends StatefulWidget {
  const IpDetailScreen({Key? key}) : super(key: key);

  @override
  _IpDetailScreenState createState() => _IpDetailScreenState();
}

class _IpDetailScreenState extends State<IpDetailScreen> {
  var data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData()async{
    var ipData = NetworkDetails.fromJson({});
    var details = await Api.getIPDetails(ipData: ipData);
    data = details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Address Detail', style: boldStyle,),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
          icon: Icon(Icons.arrow_back, color: Colors.white,),),  
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 1,
          left: 12,
          right: 12
        ),
        children: [
          //IP
          IpDetailCard(title: 'IP Address', subtitle: data?.query ?? 'Loading...', icon: Icons.lock_outlined,),

          IpDetailCard(title: 'Internet Provider', subtitle: data?.isp ?? 'Loading...', icon: CupertinoIcons.wifi,),

          IpDetailCard(title: 'Location', 
            subtitle: (data != null && data.country != null && data.country.isNotEmpty)
              ? '${data.country}, ${data.regionName}, ${data.city}'
              : 'Fetching...',
            icon: CupertinoIcons.location,),

          IpDetailCard(title: 'Pin-code', subtitle: data?.zip ?? 'Loading...', icon: Icons.lock_outlined,),

          IpDetailCard(title: 'Timezone', subtitle: data?.timezone ?? 'Loading...', icon: CupertinoIcons.time,),
        ],
        physics: BouncingScrollPhysics(),
      )
    );
  }
}

