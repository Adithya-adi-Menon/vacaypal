import 'dart:ui';
import 'screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:vacationpal/screens/swipe/index.dart';

final Map<IconData, Widget> pages = {
  Icons.home: new CardDemo(),
  Icons.add: Home(),
  Icons.person: Home(),
};
