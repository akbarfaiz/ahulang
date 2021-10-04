import 'package:ahulang/api/collection_service.dart';
import 'package:ahulang/model/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  var uid;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signUp(Account account) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: account.email, password: account.password);
      User? user = result.user;
      user!.updateDisplayName(account.name);
      await CollectionService(uid: user.uid)
          .updateUserData(account.name, account.nip, account.sector);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  Future<User> getUser() async {
    var firebaseUser = await _auth.currentUser!;
    return firebaseUser;
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}
