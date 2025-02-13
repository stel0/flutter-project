import 'package:curso_de_verano/account_screen.dart';
import 'package:curso_de_verano/home_screen.dart';
import 'package:curso_de_verano/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {

  static const routeName = "/navigator";

  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    QrScannerScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: "QR Scanner",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ]),
    );
  }
}