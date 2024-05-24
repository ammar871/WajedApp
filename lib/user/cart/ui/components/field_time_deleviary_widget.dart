import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/constants/layout/app_fonts.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/theming/font_weight_helper.dart';

class FieldTimeDeleviaryWidget extends StatelessWidget {
  const FieldTimeDeleviaryWidget({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: 10.w, left: 10.w, top: 10.h, bottom: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0.r),
        border: Border.all(width: .5, color: Colors.grey),
      ),
      child: TextField(
        controller: _controller,
        autofocus: false,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: Strings.notOrder.tr(),
          border: InputBorder.none,
          hintStyle: const TextStyle(
              fontFamily: AppFonts.stc,
              color: Palette.kDarkGrey,
              fontWeight: FontWeightHelper.light),
        ),
      ),
    );
  }
}

