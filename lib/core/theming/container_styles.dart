import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';

import '../constants/layout/app_sizes.dart';

class ContainerStyles {
  static BoxDecoration durationGGradientBlue = BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xff2072E0),
          const Color(0xff2072E0).withOpacity(.8),
          const Color(0xff2072E0).withOpacity(.6),
          const Color(0xff2072E0).withOpacity(.4),
        ],
      ));

  static BoxDecoration elevationContainner = BoxDecoration(
    borderRadius: BorderRadius.circular(7.0.r),
    color: const Color(0xffffffff),
    boxShadow: const [
      BoxShadow(
        color: Color(0x29000000),
        offset: Offset(0, 1),
        blurRadius: 13,
      ),
    ],
  );

  static BoxDecoration elevationImageContainner = BoxDecoration(
    borderRadius: BorderRadius.circular(7.0),
    image: const DecorationImage(
      image: AssetImage(''),
      fit: BoxFit.cover,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0x29000000),
        offset: Offset(0, 3),
        blurRadius: 2,
      ),
    ],
  );

  static BoxDecoration statusDurationContainner = BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.s50.r),
      ),
      border: Border.all(color: Palette.kGreyColor, width: 1));

  static BoxDecoration decorationMap(
    double radius, {
    color,
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29b6b6b6),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      );

  static BoxDecoration decorationButtonNav() => const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff082e47),
        boxShadow: [
          BoxShadow(
            color: Color(0x8c006699),
            offset: Offset(0, 0),
            blurRadius: 12,
          ),
        ],
      );

  static BoxDecoration durationImage = const BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Color(0x59000000),
        offset: Offset(0, 3),
        blurRadius: 6,
      ),
    ],
  );
}
