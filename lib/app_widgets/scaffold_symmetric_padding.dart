import 'package:flutter/material.dart';

class CustomHorizontalPadding extends StatelessWidget {
  final Widget child;
  final double padding;

   const CustomHorizontalPadding({
    Key? key,
    required this.child,
    this.padding = 20.0,  // Default horizontal padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
