import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius;
  final double padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = const Color.fromARGB(255, 238, 238, 238),
    this.iconColor = Colors.black,
    this.borderRadius = 10.0,
    this.padding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        padding: EdgeInsets.all(padding),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }
}
