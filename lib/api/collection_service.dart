import 'package:ahulang/api/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CollectionService extends GetxController {
  final firebase = FirebaseFirestore.instance;
  final String? uid;
  CollectionService({this.uid});
  Map dataUser = {'name': '', 'nip': '', 'sector': ''};

  AuthService auth = AuthService();

  void onReady() {
    super.onReady();
    getData();
  }

  final CollectionReference collect =
      FirebaseFirestore.instance.collection('account');

  Future updateUserData(String name, String nip, String sector) async {
    return await collect
        .doc(uid)
        .set({'name': name, 'nip': nip, 'sector': sector});
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await collect.doc(uid).get();
  }

  Future<void> getData() async {
    try {
      var response = await firebase
          .collection('account')
          .where('uid', isEqualTo: auth.uid)
          .get();

      if (response.docs.length > 0) {
        dataUser['name'] = response.docs[0]['name'];
        dataUser['nip'] = response.docs[0]['nip'];
        dataUser['sector'] = response.docs[0]['sector'];
      }
      print(dataUser);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
