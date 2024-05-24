import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wajed_app/core/constants/layout/app_fonts.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/theming/font_weight_helper.dart';

class TextStyles {
  static TextStyle textStyleFontBold20Black = TextStyle(
    fontSize: 20.sp,
    fontFamily: AppFonts.stc,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textStyleFontBold20CloseMarket = TextStyle(
    fontSize: 20.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kStoreClosedColor,
    fontWeight: FontWeight.bold,
  );
    static TextStyle textStyleFontBold118Black = TextStyle(
    fontSize: 18.sp,
    fontFamily: AppFonts.stc,
    color: const Color(0xff3E3E3E),
    fontWeight: FontWeight.bold,
  );

      static TextStyle textStyleFontBold13MainColor = TextStyle(
    fontSize: 12.sp,
    fontFamily: AppFonts.stc,
    color: Palette.mainColor,
    fontWeight: FontWeight.bold,
  );
   static TextStyle textStyleFontBold12bblack = TextStyle(
    fontSize: 12.sp,
    fontFamily: AppFonts.stc,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textStyleFontBold27White = TextStyle(
    fontSize: 27.sp,
    fontFamily: AppFonts.stc,
    color:  Colors.white,
    fontWeight: FontWeight.bold,
  );
   static TextStyle textStyleFontBold45White = TextStyle(
    fontSize: 45.sp,
    fontFamily: AppFonts.stc,
    color:  Colors.white,
    fontWeight: FontWeight.bold,
  );


   static TextStyle textStyleFontBold27Black = TextStyle(
    fontSize: 27.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.kDarkGrey,
    fontWeight: FontWeight.bold,
  );

    static TextStyle textStyleFontLight14White = TextStyle(
    fontSize:14.sp,
    fontFamily: AppFonts.stc,
    color:  Colors.white,
    fontWeight: FontWeightHelper.light,
  );

      static TextStyle textStyleFontLight10lack = TextStyle(
    fontSize:10.sp,
    fontFamily: AppFonts.stc,
    color:  Colors.black,
    fontWeight: FontWeightHelper.light,
  );
     static TextStyle textStyleFontLight12kDarkGrey = TextStyle(
    fontSize:12.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.kDarkGrey,
    fontWeight: FontWeightHelper.light,
  );

    static TextStyle textStyleFontBold12kDarkGrey = TextStyle(
    fontSize:12.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.kDarkGrey,
    fontWeight: FontWeightHelper.bold,
  );

    static TextStyle textStyleFontLight10Grey = TextStyle(
    fontSize:10.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.kGreyColor,
    fontWeight: FontWeightHelper.light,
  );

      static TextStyle textStyleFontLight20ColorResturant = TextStyle(
    fontSize:20.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.restaurantColor,
    fontWeight: FontWeightHelper.light,
    height: 1,
  
  );

     static TextStyle textStyleFontBold16ColorResturant = TextStyle(
    fontSize:16.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.restaurantColor,
    fontWeight: FontWeightHelper.bold,
    height: 1,
  
  );
      static TextStyle textStyleFontBold30ColorResturant = TextStyle(
    fontSize:30.sp,
    fontFamily: AppFonts.stc,
    color:  Palette.restaurantColor,
    fontWeight: FontWeightHelper.bold,
     height: 1,
       overflow: TextOverflow.ellipsis
  );
      static TextStyle textStyleFontBold150Black = TextStyle(
    fontSize: 50.sp,
    fontFamily: AppFonts.stc,
    color:  Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textStyleFontBold16White = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color: Colors.white,
      fontWeight: FontWeight.bold);


        static TextStyle textStyleFontBold20White = TextStyle(
      fontSize: 20.sp,
      fontFamily: AppFonts.stc,
      color: Colors.white,
      fontWeight: FontWeight.bold);

      //   static TextStyle textStyleFontBold20resturantColor = TextStyle(
      // fontSize: 20.sp,
      // fontFamily: AppFonts.stc,
      // color: Palette.restaurantColor,
      // fontWeight: FontWeight.bold);


            static TextStyle textStyleFontBold20resturantColor = TextStyle(
      fontSize: 20.sp,
      fontFamily: AppFonts.stc,
      color: Palette.restaurantColor,
      fontWeight: FontWeight.bold);

      static TextStyle textStyleFontBold16BlackAppBar = TextStyle(
      fontSize: 20.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kDarkGrey,
      fontWeight: FontWeight.bold);


        static TextStyle textStyleFontBold16fontGreyColor = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color: Palette.fontGreyColor,
      fontWeight: FontWeight.bold);


      static TextStyle textStyleFontBold16OrangeColor = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kOrangeColor,
      fontWeight: FontWeight.bold);

   static TextStyle textStyleFontBold20OrangeColor = TextStyle(
      fontSize: 20.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kOrangeColor,
      fontWeight: FontWeight.bold);



   static TextStyle textStyleFontBold20mainColor = TextStyle(
      fontSize: 20.sp,
      fontFamily: AppFonts.stc,
      color: Palette.mainColor,
      fontWeight: FontWeight.bold);


      static TextStyle textStyleFontRegular10greyColor = TextStyle(
      fontSize: 10.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.regular);

   static TextStyle textStyleFontRegular10WhiteColor = TextStyle(
      fontSize: 10.sp,
      fontFamily: AppFonts.stc,
      color: Palette.white,
      fontWeight: FontWeightHelper.regular);

      static TextStyle textStyleFontRegular16greyColor = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color:  Palette.fontGreyColor,
   
      fontWeight: FontWeightHelper.regular);


       static TextStyle textStyleFontRegular12fontGreyColor = TextStyle(
      fontSize: 12.sp,
      fontFamily: AppFonts.stc,
      color:  Palette.fontGreyColor,
   
      fontWeight: FontWeightHelper.regular);


      static TextStyle textStyleFontRegular12greyColor = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color: const Color(0xffB7B7B7),
      fontWeight: FontWeightHelper.regular);



       static TextStyle textStyleFontRegular14greyColor = TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.regular);

      static TextStyle textStyleFontBold16greyColor = TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.stc,
      color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.bold);

  // static TextStyle textStyleFontBold12kDarkGrey = TextStyle(
  //   fontSize: 12.sp,
  //   fontFamily: AppFonts.stc,
  //   color: Palette.kDarkGrey,
  //     fontWeight: FontWeight.bold,
  // );

   static TextStyle textStyleFontBold37kDarkGrey = TextStyle(
    fontSize: 37.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kDarkGrey,
      fontWeight: FontWeight.bold,
      height: 1.2
  );

    static TextStyle textStyleFontReqluar12kDarkGrey = TextStyle(
    fontSize: 12.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.regular,
  );


    static TextStyle textStyleFontReqular20kDarkGrey = TextStyle(
    fontSize: 20.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.regular,
  );

      static TextStyle textStyleFontReqular26kBlack = TextStyle(
    fontSize: 26.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kBlackColor,
      fontWeight: FontWeightHelper.regular,
  );

   static TextStyle textStyleFontBold20kDarkGrey = TextStyle(
    fontSize: 20.sp,
    fontFamily: AppFonts.stc,
    color: Palette.kDarkGrey,
      fontWeight: FontWeightHelper.bold,
  );
      
      static TextStyle textStyleFontReqular16kDarkGrey = TextStyle(
    fontSize:16.sp,
    fontFamily: AppFonts.stc,
    color: Palette.fontGreyColor,
      fontWeight: FontWeightHelper.bold,
  );
      

      static TextStyle textStyleFontMedium20MainColor = TextStyle(
    fontSize:20.sp,
    fontFamily: AppFonts.stc,
    color: Palette.mainColor,
      fontWeight: FontWeightHelper.medium,
  );
      

}
