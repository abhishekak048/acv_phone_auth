import 'package:acv_login_auth/Phone_auth/Phone_screen.dart';
import 'package:acv_login_auth/cwc_email_auth/food_api.dart';
import 'package:acv_login_auth/cwc_email_auth/model/user.dart';
import 'package:acv_login_auth/cwc_email_auth/notifier/auth_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final Color colors = Color(0xfffe9721);

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
    } else {
      signup(_user, authNotifier);
    }
  }

  Widget _buildDisplayNameField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Display Name",
          hintStyle: TextStyle(
              color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 20),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 26, color: Colors.white),
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Display Name is required';
          }

          if (value.length < 5 || value.length > 12) {
            return 'Display Name must be betweem 5 and 12 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.displayName = value;
        },
      ),
    );
  }

  // Widget _buildEmailField() {
  //   return Container(
  //     height: 50,
  //     margin: EdgeInsets.only(left: 40, right: 40),
  //     child: TextFormField(
  //       decoration: InputDecoration(
  //         labelText: "Email",
  //         helperText: "abc@gmail.com",
  //         hintStyle: TextStyle(color: Colors.grey.shade700),
  //         filled: true,
  //         fillColor: Color(0xff161d27).withOpacity(0.9),
  //         enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide(color: colors)),
  //         focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide(color: colors)),
  //       ),
  //       style: TextStyle(fontSize: 26, color: Colors.white),
  //       keyboardType: TextInputType.emailAddress,
  //       cursorColor: Colors.white,
  //       validator: (String value) {
  //         if (value.isEmpty) {
  //           return 'Email is required';
  //         }

  //         if (!RegExp(
  //                 r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
  //             .hasMatch(value)) {
  //           return 'Please enter a valid email address';
  //         }

  //         return null;
  //       },
  //       onSaved: (String value) {
  //         _user.email = value;
  //       },
  //     ),
  //   );
  // }

  Widget _buildEmailField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
              color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 20),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
        ),
        style: TextStyle(fontSize: 18, color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        onSaved: (String value) {
          _user.email = value;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
              color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 20),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
        ),
        style: TextStyle(fontSize: 26, color: Colors.white),
        cursorColor: Colors.white,
        obscureText: true,
        controller: _passwordController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is required';
          }

          if (value.length < 5 || value.length > 20) {
            return 'Password must be betweem 5 and 20 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "ConfirmPassword",
          hintStyle: TextStyle(
              color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 20),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colors)),
        ),
        style: TextStyle(fontSize: 26, color: Colors.white),
        cursorColor: Colors.white,
        obscureText: true,
        validator: (String value) {
          if (_passwordController.text != value) {
            return 'Passwords do not match';
          }

          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              key: _formKey,
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
                    height: 15,
                  ),
                  _authMode == AuthMode.Signup
                      ? _buildDisplayNameField()
                      : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildEmailField(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildPasswordField(),
                  SizedBox(
                    height: 15,
                  ),
                  _authMode == AuthMode.Signup
                      ? _buildConfirmPasswordField()
                      : Container(),
                  SizedBox(
                    height: 15,
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
                          _authMode == AuthMode.Login ? 'Login' : 'Signup',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          _submitForm();
                        }),
                  ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "If you want ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          '${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                          style: TextStyle(
                              color: colors, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//                   height: 50,
//                   margin: EdgeInsets.only(left: 40, right: 40),
//                   child: TextField(
//                     obscureText: true,
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       hintStyle: TextStyle(color: Colors.grey.shade700),
//                       filled: true,
//                       fillColor: Color(0xff161d27).withOpacity(0.9),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(color: colors)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(color: colors)),
//                     ),
//                   ),
//                 ),
