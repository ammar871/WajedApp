import 'package:flutter/material.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';


import '../constants/layout/app_radius.dart';
import '../constants/layout/app_sizes.dart';
import '../constants/layout/palette.dart';


class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    Key? key,
    required this.title,
    required this.subTitle,
    this.hasIcon = false,
    this.widget = const SizedBox(),
    this.titleColor = Palette.kDarkGrey,
    this.hasBackgroundColor = true,
    this.hasFullWidth = true,
    this.isDark = false,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final bool hasIcon;
  final Widget widget;
  final Color titleColor;
  final bool hasBackgroundColor;
  final bool hasFullWidth;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
      width: hasFullWidth ? context.wSize : context.wSize * 0.60,
      height: AppSize.s40,
      decoration: BoxDecoration(
        color: hasBackgroundColor
            ? Palette.kStepperLineInactiveColor
            : Colors.transparent,
        borderRadius: AppRadius.bottomRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.titleS.copyWith(
              color: isDark ? Palette.kBlackColor : titleColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          hasIcon
              ? widget
              : Text(
                  subTitle,
                  style: context.titleM.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: isDark ? Palette.kBlackColor : Palette.kDarkGrey,
                    fontWeight: isDark ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
        ],
      ),
    );
  }
}
