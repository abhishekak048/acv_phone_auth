import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'Login_screen.dart';

final Color colors = Color(0xfffe9721);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Local authenication
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Please authenticate to view your transaction overview",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 20,
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
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () async {
                      if (await _isBiometricAvailable()) {
                        await _getListOfBiometricTypes();
                        await _authenticateUser();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Homescreen extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(
//                         'assets/White wall, yellow lamp, minimal, decoration, 950x1534 wallpaper.jpg'),
//                     fit: BoxFit.cover)),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//               Colors.transparent,
//               Colors.transparent,
//               Color(0xff161d27).withOpacity(0.9),
//               Color(0xff161d27),
//             ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Text(
//                   "Welcome!",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 38,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.only(left: 40, right: 40),
//                   child: FlatButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()));
//                     },
//                     color: colors,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Text(
//                       "Get Started",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
