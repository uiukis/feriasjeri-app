import 'package:flutter/material.dart';
import 'dart:math' as math;

class Expandable extends StatefulWidget {
  const Expandable({
    super.key,
    this.width,
    this.titlePadding,
    this.paddingCurve,
    this.duration = const Duration(milliseconds: 500),
    this.closedHeight,
    this.openedHeight,
    this.backgroundcolor,
    this.borderRadius,
    required this.title,
    required this.content,
    this.iconColor,
    this.iconSize,
    this.spaceBetweenBodyTitle,
    this.isScrollable = false,
    this.outerClosedPadding,
    this.outerOpenedPadding,
    this.curve,
  });

  final Widget title;
  final Widget content;
  final double? width;
  final double? closedHeight;
  final double? spaceBetweenBodyTitle;
  final double? openedHeight;
  final EdgeInsets? titlePadding;
  final double? outerClosedPadding;
  final double? outerOpenedPadding;
  final Curve? paddingCurve;
  final Curve? curve;
  final Duration duration;
  final Color? backgroundcolor;
  final Color? iconColor;
  final double? iconSize;
  final BorderRadius? borderRadius;
  final bool isScrollable;

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> containerAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> fadeAnimation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });

    containerAnimation = Tween<double>(
            begin: widget.closedHeight ?? 70, end: widget.openedHeight ?? 250)
        .animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.curve ?? Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});

    rotateAnimation =
        Tween<double>(begin: 0, end: math.pi).animate(animationController);

    fadeAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.sizeOf(context).width,
      height: widget.isScrollable == true
          ? containerAnimation.value
          : animationController.isAnimating
              ? containerAnimation.value
              : null,
      padding: widget.titlePadding ??
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundcolor ?? Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      ),
      child: ListView(
        physics: widget.isScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: widget.isScrollable ? false : true,
        children: [
          InkWell(
            onTap: () {
              if (animationController.isDismissed) {
                setState(() {
                  isLoading = !isLoading;
                });
                animationController.forward();
              } else {
                animationController.reverse();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title,
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotateAnimation.value,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.iconColor ?? Colors.white,
                        size: widget.iconSize ?? 25,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (!animationController.isDismissed)
            GestureDetector(
              onTap: () {
                animationController.isCompleted
                    ? animationController.reverse()
                    : animationController.forward();
                setState(() {
                  isLoading = !isLoading;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.spaceBetweenBodyTitle ?? 20,
                  ),
                  FadeTransition(opacity: fadeAnimation, child: widget.content),
                ],
              ),
            )
        ],
      ),
    );
  }
}
