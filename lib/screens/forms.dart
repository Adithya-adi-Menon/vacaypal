import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacationpal/helper/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Events'),
      ),
      body: Form(

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: myController,
            ),
            TextFormField(
              controller: myController1,
            ),
            ClipOval(
              child:SizedBox(
                width: 100.0,
                height: 100.0,
                child: (_image!=null)?Image.file(_image,fit:BoxFit.fill)
                    :Image.network(
                  "https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx",fit: BoxFit.fill,
                )
              )
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
              color: Colors.blueGrey,
              onPressed: (){
                  uploadPic(context);
              },
              elevation: 4.0,
              splashColor: Colors.blueGrey,
              child: Text(
                'Submit',

              ),
            ),
            FlatButton(
              onPressed: (){
                Map<String,dynamic> data = {"field1":myController.text,"field2":myController1.text};
                Firestore.instance.collection("placed").add(data);
              },
              child: Text("submit"),
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: (){
          return showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Column(
                children: [
                  Text(myController.text),
                  Text(myController1.text)

                ],
              )

            );
          },
          );
        },
          tooltip: 'show me the value ',
          child: Icon(Icons.text_fields),
    ),


    );
  }
}
