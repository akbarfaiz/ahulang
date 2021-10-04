import 'package:ahulang/screen/history_screen.dart';
import 'package:ahulang/screen/homescreen.dart';
import 'package:ahulang/screen/login_screen.dart';
import 'package:ahulang/screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/auth_service.dart';
import 'model/route_manager.dart';
import 'model/tab_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> keyword = [];
  TextEditingController searchController = TextEditingController();
  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();

  static List<Widget> pages = <Widget>[
    ProfileScreen(),
    HomeScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(
      builder: (context, TabManager tabManager, child) {
        return WillPopScope(
          onWillPop: () => _onBackPressed(),
          child: Scaffold(
            appBar: AppBar(
              title:
                  Text('Ahulang', style: Theme.of(context).textTheme.headline6),
              automaticallyImplyLeading: false,
              actions: [
                PopupMenuButton<int>(
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) =>
                        [PopupMenuItem<int>(value: 0, child: Text("Sign Out"))])
              ],
            ),
            // 2
            body: pages[tabManager.selectedTab],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor:
                  Theme.of(context).textSelectionTheme.selectionColor,
              // 3
              currentIndex: tabManager.selectedTab,
              onTap: (index) {
                // 4
                tabManager.goToTab(index);
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        await AuthService.signOut().then((value) => Navigator.of(context)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false));
        Navigator.pushNamed(context, RouteManager.LoginPage);
        break;
    }
  }

  Future<bool> _onBackPressed() async {
    final keluar = await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'Are you sure?',
          style: TextStyle(color: Colors.black),
        ),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new GestureDetector(
              onTap: () {
                SystemNavigator.pop();
                Navigator.of(context).pop(true);
              },
              child: Text("Yes"),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("No"),
            ),
          ),
        ],
      ),
    );
    return keluar ?? false;
  }
}
