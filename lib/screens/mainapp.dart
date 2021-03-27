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
        //color: Colors.white,
        //buttonBackgroundColor: Colors.white,
        //backgroundColor: Color(0xFF695DAE),
        //animationCurve: Curves.easeInOut,
        //animationDuration: Duration(milliseconds: 600),
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
