import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';

import '../../../../core/common_widgets/image_network.dart';
import '../../../../core/common_widgets/rating_bar_widget.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/container_styles.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/market_model.dart';


class DetailsMarketCard extends StatelessWidget {

  final MarketModel market;
  const DetailsMarketCard({
    super.key, required this.market,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
  
        margin: const EdgeInsets.all(20).w,
        padding: const EdgeInsets.all(15).w,
        decoration: ContainerStyles.elevationContainner,
        child: Row(children: [
          /// image and rate
          /// // Adobe XD layer: 'download (3)' (shape)
          Column(
            children: [
              Container(
                decoration: ContainerStyles.elevationImageContainner,
                height: 80.h,
                width: 64.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.r),
                    child: ImageNetworkWidget(
                        height: 64.h,
                        width: 64.w,
                        fit: BoxFit.cover,
                        imageUrl: market.imageLogo),
                  ),
                ),
              ),
              verticalSpace(8.h),
              RatingBarWidget(
                rate:market.rate,
                size: 10.w,
              )
            ],
          ),
          horizontalSpace(14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// name MARKET AND Status and distanc
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        isAraic()?market.titleAr:market.titleEng,
                        maxLines: 2,
                        style: TextStyles.textStyleFontBold16OrangeColor
                            .copyWith(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Row(
                      children: [
                        ContainerStatusMarket(
                          text: context.toDistance(
                             market.distance),
                          backgroundColor: Colors.transparent,
                          borderColor: Palette.kDarkGrey,
                          textColor: Palette.kDarkGrey,
                        ),
                        horizontalSpace(10.w),
                        ContainerStatusMarket(
                          text: context.toStatus(
                              market.status),
                          backgroundColor:
                             market.status == 0
                                  ? Palette.mainColor
                                  : Palette.kStoreClosedColor,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    )
                  ],
                ),

                verticalSpace(7.h),

                /// desc market
                Text(
                isAraic()? market.descAr: market.descEng,
                  style: TextStyles.textStyleFontRegular16greyColor,
                ),
                verticalSpace(7.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "توصيل خلال 60 د",
                      style: TextStyles.textStyleFontRegular10greyColor,
                    ),
                    Text(
                      "توصيل مجاني",
                      style: TextStyles.textStyleFontRegular10greyColor,
                    ),
                    Text(
                      "الحد الادني 60 رس",
                      style: TextStyles.textStyleFontRegular10greyColor,
                    )
                  ],
                )
              ],
            ),
          ),
        ]));
  }
}

class ContainerStatusMarket extends StatelessWidget {
  final String text;
  final Color textColor, backgroundColor, borderColor;
  final FontWeight? fontWeight;
  const ContainerStatusMarket({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSize.s20,
    
      padding: EdgeInsets.symmetric(horizontal: AppSize.s12.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s50.r),
          ),
          border: Border.all(color: borderColor, width: 1)),
      child: Center(
        child: Text(
          text,
          style: TextStyles.textStyleFontRegular10greyColor.copyWith(
              color: textColor,
              fontWeight: fontWeight ?? FontWeightHelper.regular),
        ),
      ),
    );
  }
}
