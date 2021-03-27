
import 'dart:ui';
import 'package:vacationpal/screens/profile.dart';

import 'screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:vacationpal/screens/swipeanimation/index.dart';

final Map<IconData, Widget> pages = {
  Icons.home: new CardDemo(),
  Icons.add: Home(),
  Icons.person: Profile(),
};