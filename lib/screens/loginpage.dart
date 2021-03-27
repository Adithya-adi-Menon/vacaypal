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
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final Function toggle;
  LoginPage(this.toggle);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  Databasemethods databasemethods = new Databasemethods();
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  signMeIn() {
    if (formkey.currentState.validate()) {
      HelperFunction.saveuserEmailSharedPreference(emailController.text);

      databasemethods.getusersByEmail(emailController.text).then((value) {
        HelperFunction.saveuserNameSharedPreference(value);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signinWithEmailAndPassword(
              emailController.text, passwController.text)
          .then((value) {
        if (value == 0) {
          setState(() {
            isLoading = false;
            BotToast.showText(text: "user not Found");
          });
        } else if (value == 1) {
          setState(() {
            isLoading = false;
            BotToast.showText(text: "Incorrect Password");
            passwController.text = null;
          });
        } else if (value != null) {
          HelperFunction.saveuserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  signinwithgoogle() {
    authMethods.signInWithGoogle().then((value) {
      if (value == 0) {
        setState(() {
          isLoading = false;
          BotToast.showText(text: "user not Found");
        });
      } else if (value == 1) {
        setState(() {
          isLoading = false;
          BotToast.showText(text: "Incorrect Password");
          passwController.text = null;
        });
      } else if (value != null) {
        print(value.additionalUserInfo.profile['name']);
        print(value.additionalUserInfo.profile['email']);
        HelperFunction.saveuserEmailSharedPreference(
            value.additionalUserInfo.profile['email']);
        Map<String, String> userInfoMap = {
          "name": value.additionalUserInfo.profile['name'],
          "email": value.additionalUserInfo.profile['email'],
        };
        databasemethods.uploaduserInfo(userInfoMap);

        HelperFunction.saveuserNameSharedPreference(
            value.additionalUserInfo.profile['name']);
        HelperFunction.saveuserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Welcome",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Login into your Vacay Pal account",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Lottie.asset("assets/onboarding.json")
                        // Image.asset(
                        //   'assets/chatting.png',
                        //   width: 100,
                        //   height: 80,
                        // ),
                      ),
                      SizedBox(height: 35,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FadeAnimation(
                          1.5,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).primaryColor,
                                      blurRadius: 30,
                                      offset: Offset(1, 8))
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  
                                  
                                  FadeAnimation(
                                    1.5,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0,
                                          left: 8,
                                          top: 2,
                                          bottom: 2),
                                      child: TextFormField(
                                        validator: (val) {
                                          if (!val.isEmpty) {
                                            if (RegExp(
                                                    r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                                .hasMatch(val)) {
                                              return null;
                                            } else {
                                              return "Enter Email correctly";
                                            }
                                          } else
                                            return "Email/username";
                                        },
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple)),
                                            hintText: "Email/username"),
                                      ),
                                    ),
                                  ),
                                  
                                  FadeAnimation(
                                    1.5,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0,
                                          left: 8,
                                          top: 2,
                                          bottom: 2),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (val) {
                                          if (!val.isEmpty) {
                                            if (val.length < 4) {
                                              return "Password Too short";
                                            }
                                          } else if (val.isEmpty) {
                                            return "Enter Password";
                                          }
                                        },
                                        controller: passwController,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            hintText: "Password"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      FadeAnimation(
                          1.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                  child: Text(
                                    " Sign Up",
                                    style: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800)),
                                  ),
                                  
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 0.8,
                            height: 50,
                            onPressed: () {
                              signMeIn();
                            },
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                
                                Text('Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
