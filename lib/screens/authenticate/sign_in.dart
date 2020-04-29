import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/menu.dart';
import 'package:treeapp/screens/authenticate/register.dart';
import 'package:treeapp/services/auth.dart';
import 'package:treeapp/shared/loading.dart';
import '../../presentation/pages/list.dart';
import 'package:flutter/cupertino.dart';

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
        resizeToAvoidBottomPadding: true,
        body:
        new ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
           new SizedBox(height: 20.0,),
           new Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height: 30.0,),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  "assets/images/logo.png",
                  height: 150.0,
                  width: 210.0,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            ),
                 new Center(
                   child: new Center(
                       child: new Stack(
                           children: <Widget>[
                         Padding(
                           padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                            child: new Form(
                                key: _formKey,
                              autovalidate: false,
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: new TextFormField(
                                          autofocus: false,

                                          decoration: new InputDecoration(
                                            labelText: "Email*",
                                            hintText: "user@gmail.com",

                                            prefixIcon: Padding(padding: EdgeInsets.only(right: 7.0),child:new Image.asset(
                                              "assets/images/email_icon.png",
                                              height: 25.0,
                                              width: 25.0,
                                              fit: BoxFit.scaleDown,
                                            )),
                                          ),
                                          //keyboardType: TextInputType.emailAddress,
                                            validator: validateEmail,
                                            onChanged: (val){
                                              setState(() => email = val);
                                            }
                                        ),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0, top: 5.0),
                                          child: new TextFormField(
                                            obscureText: true,
                                            autofocus: false,
                                            decoration: new InputDecoration(

                                                labelText: "Password*",
                                                hintText: "user@Pw123",
                                                prefixIcon: Padding(padding: EdgeInsets.only(right: 7.0),child: new Image.asset(
                                                  "assets/images/password_icon.png",
                                                  height: 25.0,
                                                  width: 25.0,
                                                  fit: BoxFit.scaleDown,
                                                ))),
                                            //keyboardType: TextInputType.text,
                                              validator: validatePassword,
                                              onChanged: (val){
                                                setState(() => password = val);
                                              }
                                          )),
                                      new Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 45.0, bottom: 20.0),
                                        child: new RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(30.0)),
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
                                               },
                                          child: new Text(
                                          "Login",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                          color: Color(0xFF196b69),
                                          textColor: Colors.white,
                                          elevation: 5.0,
                                          padding: EdgeInsets.only(
                                              left: 80.0,
                                              right: 80.0,
                                              top: 15.0,
                                              bottom: 15.0),
                                        ),
                                      ),
                                new GestureDetector(
                                   onTap: () {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => Register()),
                                     );
                                   },
                                   child: new Text(
                                       "Create New Account",
                                     style: new TextStyle(
                                         color: Color(0xFF196b69),
                                         fontWeight: FontWeight.bold),

                                   ),
                                 ),
                                ],
                                )) ),
                             SizedBox(height:12.0),
                             Text(
                               error,
                               style: TextStyle(color: Colors.red, fontSize: 14.0),
                             )
                             ],
                       ),
                   ) ),
            ],
      ),
        ],
        ),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePassword(String value) {
  if (value.length < 6)
    return 'Password must be more than 6 charater';
  else
    return null;
}

