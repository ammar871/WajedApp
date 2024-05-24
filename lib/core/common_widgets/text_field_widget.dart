import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/theming/styles.dart';

import '../constants/layout/app_fonts.dart';


class TextFieldWidget extends StatelessWidget {
  final String hint;
  final Widget? icon;
   final double? hieght;
  final TextEditingController controller;
  final TextInputType? type;
  final String family;
  final bool display;
  final int maxLength;
   final int? lins;
  final bool enable, isPhone;

  const TextFieldWidget(
      {super.key,
      required this.hint,   this.lins,
       this.icon,this.hieght,
      required this.controller,
       this.type,
      this.family = AppFonts.stc,
      this.enable = true,
       this.display = false,
      this.isPhone = false,
      this.maxLength = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15.w),
      height:hieght?? 60.h,
      alignment: Alignment.center,
  
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9.0),
      color: const Color(0xffffffff),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 1),
          blurRadius: 6,
        ),
      ],
    ),
  
      child: TextField(
        enabled: enable,
        
        controller: controller,
        keyboardType: type??TextInputType.text,
        maxLength: maxLength == 0 ? null : maxLength,
        cursorColor: Palette.kDarkGrey,
        maxLines:lins ,
        textAlign: TextAlign.start,
        style:  TextStyles.textStyleFontBold16greyColor,
            obscureText: display,
        decoration: InputDecoration(
          
          isDense: false,
          fillColor: Colors.red,
          icon: icon?? const SizedBox() ,
          suffixIcon: isPhone ? icon : const SizedBox(),
          hintText: hint,
          counterText: "",
          border: InputBorder.none,
          hintStyle: TextStyles.textStyleFontReqular16kDarkGrey,
        ),
      ),
    );
  }
}
