import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter/cupertino.dart';

class PrimaryMaxWidth extends StatelessWidget {
  const PrimaryMaxWidth({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: myAppMaxWidth,
      child: child,
    );
  }
}
