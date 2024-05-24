import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/driver/ui/home_driver_screen/home_driver_screen.dart';

import '../../../core/utils/strings.dart';

class SuccessCreateAccountScreen extends StatelessWidget {
  const SuccessCreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: BackButton(
            onPressed: () {
              context.navigatePush(const HomeDriverScreen());
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(children: [
            verticalSpace(80.h),
            SvgPicture.asset("assets/icons/success.svg"),
            verticalSpace(10.h),
            Text(
              Strings.congrratolation.tr(),
              style: TextStyles.textStyleFontBold150Black,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyles.textStyleFontReqular20kDarkGrey.copyWith(),
                  text: Strings.sendOrderForReview.tr(),
                  children:  [
                    TextSpan(
                      text:Strings.sendOrderForReview2.tr(),
                    )
                  ]),
            ),
            verticalSpace(30.h),
            CustomButton(
                title: Strings.backToHome.tr(),
                onPressed: () {
                  context.navigatePush(const HomeDriverScreen());
                })
          ]),
        ),
      ),
    );
  }
}
