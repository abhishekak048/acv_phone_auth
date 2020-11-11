import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home/Login_screen.dart';
import 'Home/home_screen.dart';
import 'cwc_email_auth/notifier/auth_notifier.dart';
import 'cwc_email_auth/screens/feed.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACV Login',
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
      next: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? Feed() : Login();
        },
      ),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      until: () => Future.delayed(Duration(microseconds: 200)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      startAnimation: "ACV",
    );
  }
}
