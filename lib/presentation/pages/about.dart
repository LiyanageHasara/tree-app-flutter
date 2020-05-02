import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/text_style.dart';

import 'list.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFFbddfee4),
        child: new Stack (
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListPage())
                  );
                },
                child: Icon(Icons.navigate_next),
              ),
            ),
            // _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground () {
    return new Container(
      child: new Image.asset(
        "assets/images/forest.jpg",
        height: 100.0,
        width: 220.0,
        fit: BoxFit.scaleDown,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00b1e9a3),
            new Color(0xFFbddfee4)
          ],
          stops: [0.0, 0.7],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 120.0),
              child: new Image.asset(
                "assets/images/logo.png",
                height: 100.0,
                width: 150.0,
                fit: BoxFit.scaleDown,
              )),
          new Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("This particular app helps you in getting information regarding a plant from the experts. This app already has many plants information uploaded with proper detailing. If you are ever confused regarding plants, then this is the best plant identification app launched in 2020. It also helps you in taking care of your plant with proper guidance and instructions for making them grow healthy. It is compatible with both the platformas Android/iOS.",
                    style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


