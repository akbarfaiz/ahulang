import 'package:ahulang/home.dart';
import 'package:ahulang/screen/login_screen.dart';
import 'package:ahulang/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String LoginPage = '/';
  static const String HomePage = '/Home';
  static const String RegisterPage = '/Register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case HomePage:
        return MaterialPageRoute(builder: (context) => Home());
      case RegisterPage:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      default:
        throw FormatException('Route not found!');
    }
  }
}
