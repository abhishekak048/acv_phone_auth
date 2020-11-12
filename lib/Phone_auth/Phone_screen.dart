import 'package:acv_login_auth/Home/Login_screen.dart';
import 'package:acv_login_auth/cwc_email_auth/screens/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Feed()));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Feed()));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/White wall, yellow lamp, minimal, decoration, 950x1534 wallpaper.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.transparent,
              Color(0xff161d27).withOpacity(0.9),
              Color(0xff161d27),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Center(
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Time to cook, let's Sign in",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      hintStyle: TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w200,
                          fontSize: 18),
                      fillColor: Color(0xff161d27).withOpacity(0.9),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: colors)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: colors)),
                    ),
                    controller: _phoneController,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // TextFormField(
                //   decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           borderSide: BorderSide(color: Colors.grey[200])),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           borderSide: BorderSide(color: Colors.grey[300])),
                //       filled: true,
                //       fillColor: Colors.grey[100],
                //       hintText: "Mobile Number"),
                //   controller: _phoneController,
                // ),
                SizedBox(
                  height: 16,
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: RaisedButton(
                    color: colors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Login with Phone Number',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      final phone = _phoneController.text.trim();

                      loginUser(phone, context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )

                // Container(
                //   width: double.infinity,
                //   child: FlatButton(
                //     child: Text("LOGIN"),
                //     textColor: Colors.white,
                //     padding: EdgeInsets.all(16),
                //     onPressed: () {
                //       final phone = _phoneController.text.trim();

                //       loginUser(phone, context);
                //     },
                //     color: Colors.blue,
                //   ),
                // )
              ],
            )),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: SingleChildScrollView(
  //     child: Container(
  //       padding: EdgeInsets.all(32),
  //       child: Form(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               "Login",
  //               style: TextStyle(
  //                   color: Colors.lightBlue,
  //                   fontSize: 36,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //             SizedBox(
  //               height: 16,
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(
  //                   enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(8)),
  //                       borderSide: BorderSide(color: Colors.grey[200])),
  //                   focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(8)),
  //                       borderSide: BorderSide(color: Colors.grey[300])),
  //                   filled: true,
  //                   fillColor: Colors.grey[100],
  //                   hintText: "Mobile Number"),
  //               controller: _phoneController,
  //             ),
  //             SizedBox(
  //               height: 16,
  //             ),
  //             Container(
  //               width: double.infinity,
  //               child: FlatButton(
  //                 child: Text("LOGIN"),
  //                 textColor: Colors.white,
  //                 padding: EdgeInsets.all(16),
  //                 onPressed: () {
  //                   final phone = _phoneController.text.trim();

  //                   loginUser(phone, context);
  //                 },
  //                 color: Colors.blue,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   ));
  // }
}

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: TextStyle(color: Colors.lightBlue, fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${user.phoneNumber}",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
