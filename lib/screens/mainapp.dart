import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vacationpal/routes.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final PageController _pageController = PageController();
  int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF695DAE),
      body: PageView(
          controller: _pageController,
          children: pages.values.toList(),
          onPageChanged: (int index) {
            setState(() {
              _index = index;
              _pageController.jumpToPage(index);
            });
          }),
      bottomNavigationBar: FloatingNavbar(
        //height: 50.0,
        currentIndex: _index,
        items: pages.entries
            .map((entry) => FloatingNavbarItem(icon: entry.key, title: "Test"))
            .toList(),
        selectedBackgroundColor: Color(0xFF695DAE),
        unselectedItemColor: Color(0xFF695DAE),
        selectedItemColor: Colors.white,
        backgroundColor: Colors.white,
        onTap: (int index) {
          setState(() {
            _index = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}