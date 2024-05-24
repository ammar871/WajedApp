
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/data/models/order_status_model.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/utils/app_model.dart';

class StepperWidget extends StatelessWidget {
  final int statuse;
   const StepperWidget({super.key, required this.statuse});

 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: EasyStepper(
        activeStep: statuse,
        padding: EdgeInsets.zero,
        fitWidth: false,
        lineStyle: LineStyle(
          lineType: LineType.normal,
          lineWidth: 30,
          lineLength: 80.w,
          lineThickness: 2,
          defaultLineColor: Palette.fontGreyColor,
          activeLineColor: Palette.mainColor,
          finishedLineColor: Palette.mainColor,
        ),
        activeStepBorderType: BorderType.normal,
        defaultStepBorderType: BorderType.normal,
        finishedStepBorderType: BorderType.normal,
        unreachedStepBorderType: BorderType.normal,
        unreachedStepBackgroundColor: Palette.fontGreyColor,
        unreachedStepBorderColor: Palette.fontGreyColor,

        unreachedStepIconColor: Palette.fontGreyColor,
        unreachedStepTextColor: Palette.fontGreyColor,
        activeStepTextColor: Palette.mainColor,
        activeStepIconColor: Palette.mainColor,
        finishedStepTextColor: Palette.mainColor,
        finishedStepBackgroundColor: Palette.mainColor,
        finishedStepBorderColor:Palette.mainColor,
        finishedStepIconColor: Palette.mainColor,
        activeStepBorderColor: Palette.mainColor,
        activeStepBackgroundColor: Palette.mainColor,
        
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 8,
        showStepBorder: false,
        steps: List.generate(orderStatus.length - 1, (index) {
          OrderStatusModel orderStatusModel = orderStatus[index];
          return EasyStep(
            customStep: CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: statuse >= orderStatusModel.id ? Palette.mainColor : Colors.grey,
              ),
            ),
            title: orderStatusModel.name,
          );
        })   ),
    );
  }
}
