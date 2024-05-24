import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';

import '../../../../core/common_widgets/alert_icon_widget.dart';
import '../../../../core/constants/layout/palette.dart';

class AppBarDriverHomeWidget extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarDriverHomeWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 43.w,
                width: 43.w,
                padding: const EdgeInsets.all(10).w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    color: Palette.white),
                child: SvgPicture.asset(
                  "assets/icons/menu_market.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.dstIn),
                ),
              ),
            ),
            horizontalSpace(20.w),
            Text(
              "الرئيسية".tr(),
              style: TextStyles.textStyleFontBold20White,
            )
          ],
        )

        /// alert icon
        ,
      const AlertIconWidget(),
      ],
    );
  }
}
