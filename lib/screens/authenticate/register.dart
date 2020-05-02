import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/about.dart';
import 'package:treeapp/presentation/pages/list.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';
import 'package:treeapp/services/auth.dart';
import 'package:treeapp/shared/constants.dart';
import 'package:treeapp/shared/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Register extends StatefulWidget {

 final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String fullName = '';
  String rePassword = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: true,
        body: new ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  height: 30.0,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/logo.png",
                      height: 100.0,
                      width: 220.0,
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
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Form(
                                key: _formKey,
                                autovalidate: false,
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Padding(
                                      padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                      child: new TextFormField(
                                        decoration: new InputDecoration(
                                            labelText: "Full Name*",
                                            filled: false,
                                            prefixIcon: Padding(
                                                padding:
                                                EdgeInsets.only(right: 7.0),
                                                child: new Image.asset(
                                                  "assets/images/user_icon.png",
                                                  height: 25.0,
                                                  width: 25.0,
                                                  fit: BoxFit.scaleDown,
                                                ))
                                        ),
                                        validator: validateName,
                                        onChanged: (val){
                                          setState(() => fullName = val);
                                        }
                                        //keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 5.0),
                                        child: new TextFormField(
                                          obscureText: false,
                                          decoration: new InputDecoration(
                                              labelText: "Email-Id",
                                              enabled: true,
                                              filled: false,
                                              prefixIcon: Padding(
                                                  padding:
                                                  EdgeInsets.only(right: 7.0),
                                                  child: new Image.asset(
                                                    "assets/images/email_icon.png",
                                                    height: 25.0,
                                                    width: 25.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          validator: validateEmail,
                                          onChanged: (val){
                                            setState(() => email = val);
                                          }
                                         // keyboardType: TextInputType.text,
                                        )),
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 5.0),
                                        child: new TextFormField(
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              labelText: "Password*",
                                              enabled: true,
                                              filled: false,
                                              prefixIcon: Padding(
                                                  padding:
                                                  EdgeInsets.only(right: 7.0),
                                                  child: new Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 25.0,
                                                    width: 25.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          validator: validatePassword,
                                          onChanged: (val){
                                            setState(() => password = val);
                                          }
                                          //keyboardType: TextInputType.text,
                                        )),
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 5.0),
                                        child: new TextFormField(
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              labelText: "Confirm Password*",
                                              enabled: true,
                                              filled: false,
                                              prefixIcon: Padding(
                                                  padding:
                                                  EdgeInsets.only(right: 7.0),
                                                  child: new Image.asset(
                                                    "assets/images/password_icon.png",
                                                    height: 25.0,
                                                    width: 25.0,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                          validator: validatePassword,
                                          onChanged: (val){
                                            setState(() => rePassword = val);
                                          }
                                          //keyboardType: TextInputType.text,
                                        )),
                                    new Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.0, top: 45.0, bottom: 20.0),
                                      child: new RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(30.0)),
                                        onPressed: () async {
                                          if(password != rePassword){
                                            Fluttertoast.showToast(
                                                msg: "Two passwords do not match",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER);
                                          }
                                          else{
                                            if(_formKey.currentState.validate()){
                                              setState(() => loading = true);
                                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => AboutPage()),
                                              );
                                              if(result == null){
                                                setState(() {
                                                  error = 'please supply a valid email';
                                                  loading = false;
                                                });
                                              }
                                            }

                                          }

                                        },
                                        child: new Text(
                                          "SignUp ",
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
                                          MaterialPageRoute(builder: (context) => SignIn()),
                                        );
                                      },
                                      child: new Text(
                                        "Already have an account",
                                        style: new TextStyle(
                                            color: Color(0xFF196b69),
                                            fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ))
              ],
            )
          ],
        ));
  }

}
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else if(value == 'admin@gmail.com')
    return 'You have once signed up to the app using this mail';
  else
    return null;
}

String validatePassword(String value) {
  if (value.length < 6)
    return 'Password must be more than 6 charater';
  else
    return null;
}

String validateName(String value) {
  if (value.length < 0)
    return 'Name can not be null';
  else
    return null;
}