import 'dart:developer';

import 'package:flutter/material.dart';

class CustomSlideAnimation extends StatefulWidget {
  const CustomSlideAnimation({
    super.key,
    required this.child,
    required this.isRight,
  });

  final Widget child;
  final bool isRight;

  @override
  State<CustomSlideAnimation> createState() => _CustomSlideAnimationState();
}

class _CustomSlideAnimationState extends State<CustomSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> animationOffset;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    if (widget.isRight == true) {
      animationOffset =
          Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero)
              .animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      );
    } else {
      animationOffset =
          Tween<Offset>(begin: const Offset(2.0, 0.0), end: Offset.zero)
              .animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("## Build - CustomSlideAnimation ##");
    return SlideTransition(
      position: animationOffset,
      child: widget.child,
    );
  }
}
