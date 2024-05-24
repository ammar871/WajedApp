import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/layout/app_fonts.dart';

class FieldNoteCartWedget extends StatelessWidget {
  const FieldNoteCartWedget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(right: 10.w, left: 10.w, top: 10.h, bottom: 10.h),
      margin: EdgeInsets.only(bottom: 80.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0.r),
        border: Border.all(width: .5, color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        autofocus: false,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          // hintText: "اكتب سؤالك".tr(),
          border: InputBorder.none,
          hintStyle: TextStyle(fontFamily: AppFonts.stc, color: Colors.black),
        ),
      ),
    );
  }
}
