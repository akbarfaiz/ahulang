import 'package:ahulang/model/absen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDatabase {
  final realtime = FirebaseDatabase(
      databaseURL:
          'https://ahulang-flutter-default-rtdb.asia-southeast1.firebasedatabase.app/');

  void insertData(Absen absen, User user) {
    realtime.reference().child('absen').child(user.uid).push().set({
      'tanggal': absen.tanggal,
      'waktu': absen.waktu,
      'alamat': absen.alamat,
      'keterangan': absen.keterangan
    });
  }

  getReferences(User user) {
    return realtime.reference().child('absen').child(user.uid);
  }
}
