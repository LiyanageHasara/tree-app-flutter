import 'package:flutter/cupertino.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute(String align, {this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 700),
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
                  CurvedAnimation(parent: animation, curve: Curves.easeOut);

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
