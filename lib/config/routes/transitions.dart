import 'package:flutter/material.dart';

Widget fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child,) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Widget slideFromBottomTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,) {
  const begin = Offset(0, 1);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget slideFromRightTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,) {
  const begin = Offset(1, 0);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget scaleTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child,) {
  return ScaleTransition(
    scale: animation,
    child: child,
  );
}
