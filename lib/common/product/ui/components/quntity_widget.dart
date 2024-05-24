import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import '../../../../core/common_widgets/circle_button_widget.dart';
import '../../../../core/theming/styles.dart';

class QuntityWidget extends StatelessWidget {
  final void Function() onAdd;
   final void Function() inMinus;
  final int quntity;
  const QuntityWidget({
    super.key,
    required this.quntity, required this.onAdd, required this.inMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCircleWedget(
            icon: Icons.add,
            onPressed: onAdd,
            height: 25.h,
          ),
          horizontalSpace(5.w),
          Text(
            quntity.toString(),
            style: TextStyles.textStyleFontBold20Black,
          ),
          horizontalSpace(5.w),
          ButtonCircleWedget(
            icon: Icons.remove,
            onPressed: inMinus,
            height: 25.h,
          ),
        ],
      ),
    );
  }
}
