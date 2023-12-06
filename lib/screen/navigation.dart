import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_news_app/screen/home_screen.dart';
import 'package:simple_news_app/screen/notification_screen.dart';

final screen = [
  const HomeScreen(),
  const NotificationScreen(),
];

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xFFE9EEFA)));

    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: screen[_currentIndex],
    );
  }

  Container _bottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Discover',
          ),
        ],
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
      ),
    );
  }
}
