import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/list.dart';
import 'package:treeapp/models/user.dart';
import 'package:treeapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

//this class is responsible for navigate already looged in users to the ListPage and, new users to
//either login page or to register page


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    }

    else{
      return ListPage();
    }
  }
}

