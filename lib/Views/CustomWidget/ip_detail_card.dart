import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_app/Views/constant.dart';

class IpDetailCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;

  const IpDetailCard({Key? key, required this.title, required this.subtitle, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Card(
        elevation: 5,
        color: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
        child: ListTile(
          leading: Icon(
            icon, size: 22, color: Colors.white,
          ),
          title: Text(title, style: boldStyle .copyWith(fontSize: 16),),
          subtitle: Text(subtitle, style: mediumStyle.copyWith(color: greytext, fontSize: 13),),
        ),
      ),
    );
  }
}