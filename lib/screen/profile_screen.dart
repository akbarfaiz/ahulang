import 'dart:io';

import 'package:ahulang/api/storage_service.dart';
import 'package:ahulang/component/avatar.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/api/collection_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CollectionService collection = Get.put(CollectionService());
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference? ref;
  File? image;
  StorageService? storage = StorageService();

  Future pickImage(User user) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      final upload = storage!.uploadFile(user, imageTemporary);
      user.updatePhotoURL(await upload);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image : ${e}');
    }
  }

  Future<Null> _getUserDetail() async {
    var current = _auth.currentUser;
    ref = collection.collect;
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
    setState(() {
      _getUserDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Avatar(
            avatarUrl: user!.photoURL,
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Card(
              color: Theme.of(context).primaryColor,
              elevation: 5,
              margin: EdgeInsets.fromLTRB(75.0, 0.0, 75.0, 0.0),
              child: Container(
                height: 40,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () => pickImage(user!),
                  child: Center(
                    child: Text(
                      "Change Picture",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              )),
          Padding(padding: EdgeInsets.all(5.0)),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                enabled: false,
                controller: TextEditingController(
                    text: '${collection.dataUser['name']}'),
                decoration: InputDecoration(
                    hintText: 'name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                enabled: false,
                controller: TextEditingController(
                    text: '${collection.dataUser['nip']}'),
                decoration: InputDecoration(
                    hintText: 'nip',
                    labelText: 'NIP',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                enabled: false,
                controller: TextEditingController(text: user!.email),
                decoration: InputDecoration(
                    hintText: 'email',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                enabled: false,
                controller: TextEditingController(
                    text: '${collection.dataUser['sector']}'),
                decoration: InputDecoration(
                    hintText: 'sector',
                    labelText: 'Sector',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
          ),
        ],
      ),
    );
  }
}
