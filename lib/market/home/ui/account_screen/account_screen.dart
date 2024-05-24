import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import 'package:wajed_app/market/market/bloc/market_cubit/market_cubit.dart';
import 'package:wajed_app/market/market/ui/create_market_screen/create_market_screen.dart';
import '../../../../core/common_widgets/image_network.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/container_styles.dart';
import '../../../market/ui/create_market_screen/components/title_field_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeMarketCubit, HomeMarketState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20).w,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// * logo
                  Container(
                    height: 105.w,
                    width: 105.w,
                    decoration: ContainerStyles.durationImage.copyWith(
                        border: Border.all(
                            color: Palette.restaurantColor, width: 3)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.r),
                      child: ImageNetworkWidget(
                          height: 100.w,
                          width: 100.w,
                          fit: BoxFit.cover,
                          imageUrl:
                              state.homeResponseMarket!.data!.market.imageLogo),
                    ),
                  ),
                  verticalSpace(30.h),

                  /// * name
                  TitleFieldWidget(
                    title: Strings.nameAr.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.titleAr,
                  ),
                  verticalSpace(20.h),

                  TitleFieldWidget(
                    title: Strings.nameEng.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.titleEng,
                  ),
                  verticalSpace(20.h),

// * name ownr
                  TitleFieldWidget(
                    title: Strings.nameOwner.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.nameOwner,
                  ),
                  verticalSpace(20.h),

                  /// * desc
                  TitleFieldWidget(
                    title: Strings.descMarketAr.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.descAr,
                  ),
                  verticalSpace(20.h),

                  TitleFieldWidget(
                    title: Strings.descMarketEng.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.descEng,
                  ),

                  verticalSpace(20.h),

                  /// * address
                  TitleFieldWidget(
                    title: Strings.addrressMaket.tr(),
                  ),

                  verticalSpace(10.h),
                  FieldAccountMarketWidget(
                    value: state.homeResponseMarket!.data!.market.addressName,
                  ),
                  verticalSpace(50.h),

                  CustomButton(
                    title: "تعديل البيانات".tr(),
                    onPressed: () {
                      context.navigatePush(BlocProvider(
                        create: (context) => sl<MarketCubit>(),
                        child: CreateMarketScreen(
                          isUpdate: true,
                          marketModel: state.homeResponseMarket!.data!.market,
                        ),
                      ));
                    },
                    backgroundColor: Palette.kStoreClosedColor,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FieldAccountMarketWidget extends StatelessWidget {
  final String value;
  const FieldAccountMarketWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15).w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Palette.kGreyLightColor),
      child: Row(
        children: [
          Text(
            value,
            style: TextStyles.textStyleFontBold16ColorResturant,
          ),
        ],
      ),
    );
  }
}
