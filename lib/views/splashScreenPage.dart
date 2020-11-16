import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder/views/reminderPage.dart';

class SplashScreenPage extends StatefulWidget {
  String title;
  SplashScreenPage({title});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF144376),
      systemNavigationBarColor: Color(0xFF144376),
    ));

    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => ReminderViewPage(),
              transitionsBuilder: (context, anim, secAnim, child) =>
                  FadeTransition(
                    opacity: anim,
                    child: child,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF144376), Color(0xFF2885EB)],
                    begin: AlignmentDirectional.topCenter,
                    stops: [0.2, 0.7],
                    end: AlignmentDirectional.bottomCenter)),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: height * 0.50,
                  child: Image(
                    image: AssetImage('assets/icons/clock.png'),
                    width: 49,
                  ),
                ),
                Positioned(
                  top: height * 0.90,
                  child: Text(
                    'Reminder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      wordSpacing: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
