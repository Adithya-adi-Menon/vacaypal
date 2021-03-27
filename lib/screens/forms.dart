import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacationpal/helper/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {

  File _image;


  TextEditingController myController = new TextEditingController();
  TextEditingController myController1 = new  TextEditingController();
  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);


      setState(() {
        _image= image;
        print('Image Path $_image');
      });
    };

    Future uploadPic(BuildContext context) async{
      String fileName=basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Pic uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile picture Uploaded')));
      });
    }

    return Container(
      height: 400,
      child: Form(

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Enter the destination"),
              controller: myController,
            ),
            TextFormField(
            decoration: InputDecoration(hintText: "Enter the date"),

              controller: myController1,
            ),
            
            IconButton(
              icon: Icon(
                FontAwesomeIcons.camera,
                size: 30.0,
              ),
              onPressed: (){
                getImage();
              },
            ),
            RaisedButton(
              color: Color(0xFF695DAE),
              onPressed: (){
                  uploadPic(context);
              },
              elevation: 4.0,
              splashColor: Color(0xFF695DAE),
              child: Text(
                'Create vacay',
                 style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
      ),


    );
  }
}
