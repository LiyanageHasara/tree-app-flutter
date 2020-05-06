import 'package:flutter/cupertino.dart';

//add page animation when page routing
class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute(String align, {this.widget})
      : super(
            //https://www.youtube.com/watch?v=6vPF2IqCJ9Q&t=429s
            transitionDuration: Duration(milliseconds: 600),
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
                  CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn);

                return ScaleTransition(
                  alignment: alignment,
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
