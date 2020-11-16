import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/base/cardConfigurationController.dart';
import 'package:reminder/config/routes.dart';

void main(){
  GetIt.I.registerSingleton<CardConfigurationController>(
      CardConfigurationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder',
      initialRoute: "/splash",
      debugShowCheckedModeBanner: false,
      routes: routes(context),
      color: Color(0xFF2885EB),
      theme: ThemeData(
        primaryColor: Color(0xFF2885EB),
        backgroundColor: Color(0xFF22303D),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 23.0,
          ),
          headline2: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
          headline3: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
          headline6: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }
}
