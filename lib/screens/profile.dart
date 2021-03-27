import 'package:flutter/material.dart';
import 'package:vacationpal/services/auth.dart';
import 'package:vacationpal/helper/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:vacationpal/helper/helperfunction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vacationpal/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vacationpal/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vacationpal/services/auth.dart';
import 'package:vacationpal/helper/authenticate.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double _currentSliderValue = 30;
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Color(0xFF695DAE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.logout,
                                size: 35,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.qr_code_rounded,
                                size: 35,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    title: new Text('Share your unique QR code'),
                                    content: Container(
                                      height: 300,
                                      child: Column(
                                        children:
                                          [
                                            PrettyQr(data: "guru",
                                            roundEdges: true,
                                            size: 200,),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Center(child: Text("Please scan this QR code if you wish to add your friends in your vacay!", textAlign: TextAlign.center,))
                                          ]
                                      ),
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(); // dismisses only the dialog and returns nothing
                                        },
                                        child: new Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ]),
                    CircleAvatar(
                      radius: 60,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'NAME',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "Guru",
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'EMAIL',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "guru@gmail.com",
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'LOCATION RADIUS (KM)',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF695DAE)),
              ),
              Slider(
                activeColor: Color(0xFF695DAE),
                inactiveColor: Color(0xFF695DAE).withOpacity(0.5),
                value: _currentSliderValue,
                min: 0,
                max: 200,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.3),
              ),
              SizedBox(height: 20),
              Text(
                'LOCATION SHARING',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF695DAE)),
              ),
              Switch(value: true, onChanged: null),
              SizedBox(
                height: 15,
              ),
              Text(
                'HOSTED VACATIONS',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF695DAE)),
              ),
              SizedBox(height: 10),
              // Cards
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF695DAE)
                    ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                       Text(
                      "Taj Mahal",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20
                    ),
                    Icon(Icons.edit, color: Colors.white,)
                      ]
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
