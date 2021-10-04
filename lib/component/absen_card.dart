import 'package:ahulang/component/address_card.dart';
import 'package:ahulang/screen/absen_masuk_screen.dart';
import 'package:ahulang/screen/absen_pulang_screen.dart';
import 'package:flutter/material.dart';

class AbsenCard extends StatelessWidget {
  final String? absenDatang;
  final String? absenPulang;

  const AbsenCard(this.absenDatang, this.absenPulang, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(1, 1))
            ]),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 75, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          if (absenDatang == '-') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MasukScreen()));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                title: new Text(
                                  'Already Attendance',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: new Text('You already done present'),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.input,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text("Go Work")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 30),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          if (absenPulang == '-') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PulangScreen()));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                title: new Text(
                                  'Already Home',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: new Text('You already done present'),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.home_work,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text("Go Home")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
