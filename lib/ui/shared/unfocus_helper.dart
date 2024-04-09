import 'package:flutter/material.dart';

class UnfocusHelper extends StatelessWidget {
  const UnfocusHelper({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}