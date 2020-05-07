//this is the loading widget of the application


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(image: new AssetImage('assets/images/bckground.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SpinKitChasingDots(
          /*
I referred the following tutorial to get knowledge about loading screens
https://www.youtube.com/watch?v=Vr_ahm78h_g
 */
          color: Colors.green,
          size: 50.0,
        ),
      ),

    );
  }
}



