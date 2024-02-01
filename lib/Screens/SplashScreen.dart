import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'HomeScreen.dart';



class SplashScreen extends StatefulWidget
{
  @override
  SplashState createState() => SplashState();

}

class SplashState extends State<SplashScreen>
{

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  void checkConnection() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile)
    {
      check_if_already_login();
    }
    else if (connectivityResult == ConnectivityResult.wifi)
    {
      check_if_already_login();
    }
    else
    {
      _showConnectionDialog();
    }
  }
  void check_if_already_login()
  {
    Timer(Duration(seconds: 4), ()
    =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
    );
  }
  void _showConnectionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [Icon(Icons.error),Text("\tNetwork Error")],),
          content: Text('Please check your internet connection.',style: TextStyle(fontStyle: FontStyle.italic)),
          actions: <Widget>[
            ElevatedButton(
              onPressed: ()
              {
                SystemNavigator.pop();
              },
              child: Text("Exit",style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      Center(
        child: Column(
          children: [
            SizedBox(width: 300, height: 300,),
            Lottie.network(
              "https://roasting-conflict.000webhostapp.com/lotti/FitnessApp.json",
              /*height: 200.0,*/
              repeat: true,
              reverse: true,
              animate: true,
            ),

          ],
        ),
      ),
    );
  }
}