

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:treeapp/screens/wrapper.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), ()=> Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFbddfee4)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*
I referred the following tutorial about "Splash Screen" to build this widget
https://www.youtube.com/watch?v=FNBuo-7zg2Q
 */
                     new Image.asset(
                      "assets/images/logo.png",
                      height: 100.0,
                      width: 220.0,
                      //fit: BoxFit.scaleDown,
                    ),
                    Padding(padding: EdgeInsets.only(top:10.0)),
                  ],
                ),
              ),
            ),
              Expanded(flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text("Tree Application\n For Learners", style: TextStyle(color: Color(0xFF196b69), fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              )
          ],),
        ],
      ),
    );
  }

}