import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Date : Saturday, 24 September 2021"),
            SizedBox(
              height: 20,
            ),
            Text("Time : 07.00"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Location : "),
                Expanded(
                  flex: 6,
                  child: Text(
                    "Jalan Pangeran Natakusuma, Kecamatan Pontianak Kota, Kota Pontianak, Kalimantan Barat",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
