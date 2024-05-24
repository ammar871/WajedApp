import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/market/market/bloc/market_cubit/market_cubit.dart';
import 'package:wajed_app/market/market/ui/create_market_screen/create_market_screen.dart';
import '../../../../../core/common_widgets/custom_button.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/session_manager.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class CreateMyMarketWidget extends StatelessWidget {
  const CreateMyMarketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.restaurantColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            "الرئيسية".tr(),
            style: TextStyles.textStyleFontBold20White,
          ),
          actions: [
            MaterialButton(
              onPressed: () async {
                await SessionManager().singOut(context: context);
              },
              child: SvgPicture.asset(
                "assets/icons/logout.svg",
                width: 20.w,
                height: 20.w,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "لا يوجد لديك متجر".tr(),
                  style: TextStyles.textStyleFontBold20resturantColor,
                ),
                verticalSpace(40.h),
                CustomButton(
                  title: "انشاء متجري الآن".tr(),
                  onPressed: () {
                    context.navigatePush(BlocProvider(
                      create: (context) => sl<MarketCubit>(),
                      child: const CreateMarketScreen(),
                    ));
                  },
                  backgroundColor: Palette.restaurantColor,
                )
              ],
            ),
          ),
        ));
  }
}
