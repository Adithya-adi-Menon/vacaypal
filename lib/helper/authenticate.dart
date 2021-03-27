import 'package:flutter/material.dart';

// Page imports
import 'package:vacationpal/screens/loginpage.dart';
import 'package:vacationpal/screens/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showlogin = true;

  @override
  Widget build(BuildContext context) {
    void toggleView() {
      setState(() {
        showlogin = !showlogin;
      });
    }

    if (showlogin) {
      return LoginPage(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
