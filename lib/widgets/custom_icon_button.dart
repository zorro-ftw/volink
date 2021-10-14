import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.backGroundColor,
      this.elevation,
      this.padding,
      this.child,
      this.onTap});
  final Color backGroundColor;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: elevation != null ? elevation : 0,
        color: backGroundColor,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child:
            padding != null ? Padding(padding: padding, child: child) : child,
      ),
      onTap: onTap,
    );
  }
}
