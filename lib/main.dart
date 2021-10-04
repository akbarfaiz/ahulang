import 'package:ahulang/model/route_manager.dart';
import 'package:ahulang/screen/login_screen.dart';
import 'package:ahulang/screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ahulang_theme.dart';
import 'home.dart';
import 'model/tab_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Ahulang());
}

class Ahulang extends StatelessWidget {
  const Ahulang({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = AhulangTheme.theme();
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => TabManager(),
              ),
            ],
            builder: (context, child) {
              return MaterialApp(
                title: 'Ahulang',
                theme: theme,
                initialRoute: RouteManager.LoginPage,
                onGenerateRoute: RouteManager.generateRoute,
              );
            },
          );
        });
  }
}
