import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/home.dart';
import 'package:treeapp/models/user.dart';
import 'package:treeapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    }

    else{
      return HomePage();
    }
  }
}
