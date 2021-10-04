import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/api/realtime_database.dart';
import 'package:ahulang/component/history_card.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  RealTimeDatabase realTimeDatabase = RealTimeDatabase();
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Query? ref;

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

  @override
  void initState() {
    {
      setState(() {
        _getUserDetail();
        ref = realTimeDatabase.getReferences(user!);
      });
    }
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref!,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  title: Text(snapshot.value['tanggal']),
                  subtitle: Text('Time : ' +
                      snapshot.value['waktu'] +
                      '\n Location : ' +
                      snapshot.value['alamat']),
                  trailing: Text(snapshot.value['keterangan']),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
