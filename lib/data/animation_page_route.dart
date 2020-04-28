import 'package:flutter/cupertino.dart';
//add page animation when page routing
class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute(String align, {this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              Alignment alignment;

              if (align == 'center') {
                alignment = Alignment.center;
              } else if (align == 'bottomCenter') {
                alignment = Alignment.bottomCenter;
              } else if (align == 'centerRight') {
                alignment = Alignment.centerRight;
              } else {
                alignment = Alignment.center;
              }
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);

              return ScaleTransition(
                alignment: alignment,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
