import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/layout/palette.dart';

class ButtonCircleWedget extends StatelessWidget {
  final void Function() onPressed;
  final double height;
  final IconData icon;
  final Color? iconColor, backgroundColor;

  const ButtonCircleWedget(
      {super.key,
      required this.onPressed,
      required this.height,
      required this.icon,
      this.iconColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      color: backgroundColor ?? Colors.white,
      padding: const EdgeInsets.all(5).w,
      shape: const CircleBorder(),
      height: height,
      onPressed: onPressed,
      child: Center(
        child: Icon(
          icon,
          size: 20.w,
          color: iconColor ?? Palette.mainColor,
        ),
      ),
    );
  }
}
