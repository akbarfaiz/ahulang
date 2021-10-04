import 'dart:async';
import 'dart:io';

import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/api/collection_service.dart';
import 'package:ahulang/api/location_service.dart';
import 'package:ahulang/api/realtime_database.dart';
import 'package:ahulang/component/absen_card.dart';
import 'package:ahulang/component/check_absen_card.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:ahulang/model/user_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionService collection = Get.put(CollectionService());
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RealTimeDatabase realTimeDatabase = RealTimeDatabase();
  Query? query;
  String? waktuDatang = '-';
  String? waktuPulang = '-';

  var tgl = DateFormat("EEEE, d MMMM yyyy").format(DateTime.now()).toString();

  Future<Null> _getUserDetail() async {
    var current = _auth.currentUser;
    _auth.authStateChanges().listen((event) {
      user = event;
    });
    if (current != null) {
      setState(() {
        user = current;
      });
    } else {
      await AuthService.signOut();
      Navigator.pushNamed(context, RouteManager.LoginPage);
    }
  }

  getWaktu(Query query, String ket, String tgl) async {
    await query.get().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        if (values['tanggal'] == tgl && values['keterangan'] == ket) {
          if (ket == 'Attendance') {
            waktuDatang = values['waktu'];
            print('masuk ' + waktuDatang!);
          } else {
            waktuPulang = values['waktu'];
            print('masuk ' + waktuPulang!);
          }
        }
        /*print('Data : ${key} ' +
            tgl +
            ' ${values['tanggal']} ${values['keterangan']}');*/
      });
    });
  }

  @override
  void initState() {
    _getUserDetail();
    query = realTimeDatabase.getReferences(user!);
    getWaktu(query!, 'Attendance', tgl);
    getWaktu(query!, 'Home', tgl);
    new Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              _getUserDetail();
              query = realTimeDatabase.getReferences(user!);
              getWaktu(query!, 'Attendance', tgl);
              getWaktu(query!, 'Home', tgl);
              print(waktuDatang);
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Hai, " + user!.displayName!,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                tgl,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: AbsenCard(waktuDatang, waktuPulang)),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckAbsenCard('Work', waktuDatang),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckAbsenCard('Home', waktuPulang),
            ),
          ],
        ),
      ),
    ));
  }
}
