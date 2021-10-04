import 'dart:io';

import 'package:ahulang/api/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: 'gs://ahulang-flutter.appspot.com');

  Future<String> uploadFile(User user, File file) async {
    var storageRef = storage.ref().child('user/profile/${user.uid}');
    var uploadTask = storageRef.putFile(file);
    var completeTask = await uploadTask;
    String downloadUrl = await completeTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
