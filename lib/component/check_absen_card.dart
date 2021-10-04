import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckAbsenCard extends StatelessWidget {
  final String keterangan;
  String? waktu = '-';

  CheckAbsenCard(this.keterangan, this.waktu);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            '$keterangan',
            style: TextStyle(color: Colors.white),
          ),
          subtitle:
              Text('Time : ' + '$waktu', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
