import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/menu.dart';
import 'package:treeapp/services/auth.dart';
import 'package:treeapp/shared/constants.dart';
import 'package:treeapp/shared/loading.dart';
import '../../presentation/pages/list.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: Text('Sign in to TreeForest'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: (){
                widget.toggleView();
              }
              )
        ],
      ),
      body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage('assets/images/bckground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
               TextFormField(
                   decoration: textInputDecoration.copyWith(hintText: 'Password'),
                 obscureText: true,
                   validator: (val) => val.length<6 ? 'Enter a password 6+ characters long' : null,
                 onChanged: (val){
                   setState(() => password = val);
                 }
               ),
              SizedBox(height:20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){

                    if(email == 'admin@gmail.com'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListPage()),
                      );
                    }

                    if(email != 'admin@gmail.com'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    }


                    else {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                      if (result == null) {
                        setState(() {
                          error = 'could not sign in with those credentials';
                          loading = false;
                        });
                      }
                    }
                  }
                }
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}
