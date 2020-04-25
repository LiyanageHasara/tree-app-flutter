import 'package:flutter/material.dart';
import 'package:treeapp/models/user.dart';
import 'package:treeapp/screens/wrapper.dart';
import 'package:treeapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Tree Details Application',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Wrapper(),
      ),
    );
  }
}

