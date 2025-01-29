import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';

class LocationCard extends StatelessWidget {
  final String countryName, flag;
  final Function(bool value) tap;
  final bool isExpanded;
  final List<Widget> server;

  const LocationCard({super.key, required this.countryName, required this.flag, required this.tap, required this.isExpanded, required this.server});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),

      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              onExpansionChanged: tap,
              leading: Container(
                width: 48,
                height: 38,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/flags/${flag.toLowerCase()}.png"),
                    fit: BoxFit.fill,
                  )
                )
              ),
              title: Text(countryName, style: boldStyle.copyWith(fontSize: 16),),
              trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
              children: isExpanded ? server : [],
            ),
            Divider(color: Colors.white, indent: 5, endIndent: 5,)
          ],
        ),
      ),
    );
  }
}
