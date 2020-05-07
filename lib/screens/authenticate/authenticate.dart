import 'package:flutter/material.dart';
import 'package:treeapp/screens/authenticate/register.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';

//this class is responsible to switch users between login and register pages

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn= !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
   if(showSignIn){
     return SignIn(toggleView: toggleView);
   }else{
     return Register(toggleView: toggleView);
   }
  }
}

