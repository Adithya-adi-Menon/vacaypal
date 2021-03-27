import 'dart:async';

import 'package:vacationpal/helper/Constants.dart';
import 'package:vacationpal/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locality extends StatefulWidget {
  @override
  _LocalityState createState() => _LocalityState();
}

double lat = 12.0288317;
double long = 78.9370517;
String name1;

class _LocalityState extends State<Locality> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, markerIdVal, text) async {
    setState(() {
      lat = double.parse(specify['Location'][0]);
      long = double.parse(specify['Location'][1]);
    });
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(double.parse(specify['Location'][0]),
          double.parse(specify['Location'][1])),
      infoWindow: InfoWindow(
        title: text,
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    Firestore.instance.collection('request').getDocuments().then((myMockDoc) {
      if (myMockDoc.documents.isNotEmpty) {
        for (int i = 0; i < myMockDoc.documents.length; i++) {
          setState(() {});
          initMarker(
              myMockDoc.documents[i].data(),
              myMockDoc.documents[i].documentID,
              myMockDoc.documents[i].data()["content"]);
        }
      }
    });
  }

  double lat;
  double long;

  // savelocation() async {
  //   Position position = await Geolocator().getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   setState(() {
  //     lat = double.parse(position.latitude.toString());
  //     long = double.parse(position.longitude.toString());
  //   });
  //   print(position.latitude);
  // }
  List<String> mylocation;
  savelocation() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    lat = position.latitude;
    long = position.longitude;
    print(position.latitude);
    setState(() {
      mylocation = [lat.toString(), long.toString()];
    });
  }

  @override
  void initState() {
    getMarkerData();
    savelocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, long), zoom: 15.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
            }),
        Padding(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  TextEditingController _controller = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("What do you want to get"),
                          content: Container(
                            width: 300,
                            height: 400,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _controller,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Color(0xFFEF5A4C)),
                                  decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1.5,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w900),
                                      filled: true,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      fillColor: Colors.white.withOpacity(.3),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Firestore.instance
                                        .collection("request")
                                        .add({
                                      "content":
                                          "Request : ${_controller.text}",
                                      "Location": mylocation
                                    }).then((value) {
                                      Navigator.pop(ctx);
                                    });
                                    print("man");
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFEF5A4C),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Request",
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  getMarkerData();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFEF5A4C),
                  ),
                  child: Center(
                    child: Text(
                      "Request",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  TextEditingController _controller = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("What do you want to get"),
                          content: Container(
                            width: 300,
                            height: 400,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _controller,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Color(0xFFEF5A4C)),
                                  decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1.5,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w900),
                                      filled: true,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      fillColor: Colors.white.withOpacity(.3),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Firestore.instance
                                        .collection("request")
                                        .add({
                                      "content": "Offer : ${_controller.text}",
                                      "Location": mylocation
                                    }).then((value) {
                                      Navigator.pop(ctx);
                                    });
                                    print("man");
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFEF5A4C),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Request",
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });

                  getMarkerData()();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFEF5A4C)),
                  child: Center(
                    child: Text(
                      "Offer",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}