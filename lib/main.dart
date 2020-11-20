import 'package:acv_login_auth/email_google_sigin/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'email_google_sigin/pages/loginScreen.dart';

void main() {
  runApp(MyApp());
}

// void main() => runApp(
//   MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => AuthNotifier(),
//         ),
//       ],
//       child: MyApp(),
//     ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACV Login',
      routes: <String, WidgetBuilder>{
        '/signUp': (_) => new LoginScreen(), // The SignUp page
      },
      home: Animatation(),
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFFF2F3F7),
          accentColor: Color(0xFFFFFFFF),
          textSelectionColor: Color(0xFF707070)),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          backgroundColor: Colors.amber,
          accentColor: Color(0xFFA8A6A6),
          textSelectionColor: Color(0xFFFFFFFF)),
    );
  }
}

class Animatation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: "assets/ACV Funding.flr",
      next: HomePage(),

      // Consumer<AuthNotifier>(
      //   builder: (context, notifier, child) {
      //     return notifier.user != null ? Feed() : HomeScreen();
      //   },
      // ),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      until: () => Future.delayed(Duration(microseconds: 200)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      startAnimation: "ACV",
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ignore: unused_local_variable
          FirebaseUser user = snapshot.data;
          return Loginpage();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
