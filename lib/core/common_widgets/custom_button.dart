import 'package:flutter/material.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';

import '../constants/layout/app_fonts.dart';
import '../constants/layout/app_radius.dart';
import '../constants/layout/app_sizes.dart';
import '../constants/layout/palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.backgroundColor = Palette.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Palette.white,
    required this.onPressed,
    this.elevation = 2.0,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
            backgroundColor,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: AppRadius.r10,
                side: borderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: AppRadius.r10,
            );
          }),
        ),
        child: Text(
          title,
          style: context.titleM.copyWith(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.stc,
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    Key? key,
    required this.title,
    this.backgroundColor = Palette.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Palette.white,
    required this.onPressed,
    this.elevation = 2.0,
    required this.icon,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double elevation;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s46,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          title,
          style: TextStyle(
            color: titleColor,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: AppRadius.r10,
                side: borderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: AppRadius.r10,
            );
          }),
        ),
      ),
    );
  }
}

class CustomButtonWithChild extends StatelessWidget {
  const CustomButtonWithChild({
    Key? key,
  
    this.backgroundColor = Palette.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Palette.white,
    required this.onPressed,required this.child,
     this.elevation = 2.0,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;

  final Color titleColor;
  final VoidCallback? onPressed;
  final Widget child;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
            backgroundColor,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: AppRadius.r10,
                side: borderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: AppRadius.r10,
            );
          }),
        ),
        child: child
        
      ),
    );
  }
}
