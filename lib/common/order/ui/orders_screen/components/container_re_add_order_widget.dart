import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class ContainerReAddOrderWidget extends StatelessWidget {
  final String title, icon;
  final VoidCallback onPressed;
  const ContainerReAddOrderWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          horizontalSpace(9.w),
          Text(title, style: TextStyles.textStyleFontReqluar12kDarkGrey),
        ],
      ),
    );
  }
}
