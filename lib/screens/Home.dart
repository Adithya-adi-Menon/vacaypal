import 'dart:ui';

import 'package:vacationpal/helper/authenticate.dart';
import 'conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:vacationpal/helper/helperfunction.dart';
import 'package:vacationpal/services/auth.dart';
import 'package:vacationpal/services/database.dart';
import 'Home.dart';
import 'signup.dart';
import 'package:vacationpal/helper/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:vacationpal/widget/colors.dart';
import 'package:vacationpal/widget/fadeanimation.dart';
import 'package:vacationpal/routes.dart';
import 'search.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Databasemethods databasemethods = new Databasemethods();
  @override
  void initState() {
    getuserinfo();
    getl();
    super.initState();
  }

  getl() {
    databasemethods.savelocation();
  }

  Query collectionReference1;
  getuserinfo() async {
    await HelperFunction.getuserNameSharedPreference().then((value) {
      Constants.MyName = value;
      setState(() {
        collectionReference1 = getinfo();
      });
    });
  }

  AuthMethods authMethods = new AuthMethods();

  @override
  void setState(fn) {
    // TODO: implement setState

    super.setState(fn);
  }

  getinfo() {
    return FirebaseFirestore.instance
        .collection('ChatRomm')
        .where("users", arrayContains: Constants.MyName);
  }

  Widget ChatRoomList() {
    return collectionReference1.snapshots() != null
        ? StreamBuilder(
            stream: collectionReference1.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data.docs[index].data()["users"][0] ==
                        Constants.MyName) {
                      return chatTile(
                          snapshot.data.docs[index].data()["users"][1],
                          snapshot.data.docs[index].data()["ChatroomId"]);
                    } else {
                      return chatTile(
                          snapshot.data.docs[index].data()["users"][0],
                          snapshot.data.docs[index].data()["ChatroomId"]);
                    }
                  });
            })
        : Container();
  }

  Widget chatTile(final String username, String chatroomid) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Conversation(
                      chateeeroomid: chatroomid,
                      recipent: username,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                child: Center(
                    child: Text(
                  username.substring(0, 1).toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      username,
                      style: GoogleFonts.robotoMono(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF695DAE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Vacation Pal",
        
        style: GoogleFonts.robotoMono(color: Color(0xFF695DAE), fontWeight: FontWeight.bold)),
        
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              }),
        ],
        
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFEF5A4C),
          child: Icon(Icons.group_add,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => searchScreen()));
          }),
    );
  }
}
