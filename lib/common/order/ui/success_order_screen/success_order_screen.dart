import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
import 'package:wajed_app/common/order/ui/traking_order_screen/traking_order_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/home/ui/home_screen/home_screen.dart';

class SuccessOrderScreen extends StatelessWidget {
  final OrderModel orderModel;
  const SuccessOrderScreen({super.key, required this.orderModel});

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
              context.navigatePush(const HomeScreen());
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
                  text: Strings.thanks.tr(),
                  children: [
                    TextSpan(
                      text: orderModel.id.toString(),
                    ),
                     TextSpan(
                      text:
                         Strings.thanks2.tr(),
                    )
                  ]),
            ),
            verticalSpace(30.h),
            CustomButton(title: Strings.followOrder.tr(), onPressed: () {
              context.navigatePush(TrakingOrderScreen(orderId: orderModel.id));
            })
          ]),
        ),
      ),
    );
  }
}
