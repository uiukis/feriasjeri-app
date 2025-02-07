import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomModalBottomSheet {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsets padding;
  final bool expand;
  final Color barrierColor;
  final VoidCallback? onDismissed;

  CustomModalBottomSheet({
    required this.child,
    this.borderRadius = 20.0,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16),
    this.expand = false,
    this.barrierColor = Colors.black87,
    this.onDismissed,
  }) {
    showCupertinoModalBottomSheet(
      context: Get.context!,
      expand: expand,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
        ),
        padding: padding,
        child: child,
      ),
    ).then((_) {
      if (onDismissed != null) {
        onDismissed!();
      }
    });
  }
}
