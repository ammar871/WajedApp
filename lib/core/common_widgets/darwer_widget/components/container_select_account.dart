import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/helpers/spacing.dart';

import '../../../theming/styles.dart';

class ContainerSelectAccount extends StatelessWidget {
  final String name;
  final String icon;
  final void Function() onTap;

  const ContainerSelectAccount(
      {super.key, required this.name, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: const Color(0xffffffff),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            horizontalSpace(10.w),
            Text(
              name,
              style: TextStyles.textStyleFontBold13MainColor,
            )
          ],
        ),
      ),
    ));
  }
}
