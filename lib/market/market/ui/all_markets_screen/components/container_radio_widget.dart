import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class ContainerRadioWidget extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onChange;
  const ContainerRadioWidget(
      {super.key, required this.color, required this.onChange, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        height: 70.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Palette.kDarkGrey, width: .5.h))),
        child: Row(
          children: [
            Container(
              height: 20.w,
              width: 20.w,
              padding: EdgeInsets.all(2).w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Palette.mainColor, width: 2.w)),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ),
            horizontalSpace(20.w),
            Text(
             title,
              style: TextStyles.textStyleFontMedium20MainColor,
            ),
          ],
        ),
      ),
    );
  }
}
