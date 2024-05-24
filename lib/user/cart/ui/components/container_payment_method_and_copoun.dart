
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';

import '../../../../core/constants/layout/palette.dart';
import '../../../../core/theming/styles.dart';

class ContainerPaymentMethodAndCopoun extends StatelessWidget {
  final String title, value;
  final Color textColor;
  final IconData icon;
  final void Function() onPress;

  const ContainerPaymentMethodAndCopoun(
      {super.key,
      required this.title,
      required this.value,
      required this.textColor,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width / 3.5,
          child: Text(
            title,
            style: TextStyles.textStyleFontReqular16kDarkGrey,
          ),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: Palette.kStepperLineInactiveColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyles.textStyleFontBold16greyColor
                        .copyWith(color: textColor),
                  ),
                  horizontalSpace(20.w),
                  MaterialButton(
                    onPressed: onPress,
                    minWidth: 40.w,
                    height: 40.h,
                    child: Icon(
                      icon,
                      color: Palette.kDarkGrey,
                      size: 15.w,
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
