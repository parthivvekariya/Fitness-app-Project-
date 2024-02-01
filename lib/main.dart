
//Well India project
//https://music.youtube.com/watch?v=1FdMm_O7it8&si=1dfV3ut4YXh78iTO

import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/SplashScreen.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;



void main() async {
  tzdata.initializeTimeZones();

  // Set the default time zone to 'Asia/Kolkata' (India Standard Time)
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

  runApp(MyApp());
}


class MyApp extends StatelessWidget
{



  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Well India',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

}

//https://www.appicon.co/
