import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final EdgeInsetsGeometry? padding;

  const CustomInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory, // ⬅️ splash hilang
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: highlightColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
