import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/container_styles.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../market/data/models/market_model.dart';

class DetailsMarketWidget extends StatelessWidget {
  final MarketModel market;
  const DetailsMarketWidget({
    super.key,
    required this.market,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Container(
              height: 70.w,
              width: 70.w,
              decoration: ContainerStyles.durationImage,
              child: ImageNetworkWidget(imageUrl: market.imageLogo),
            ),
          ),
          horizontalSpace(20.w),
          // * name mraket
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                  child: Text(
                    Strings.welcome.tr(),
                    style: TextStyles.textStyleFontLight20ColorResturant,
                  ),
                ),
                SizedBox(
                  child: Text(
                    isAraic()?market.titleAr:market.titleEng,
                    maxLines: 2,
                    style: TextStyles.textStyleFontBold30ColorResturant,
                  ),
                )
              ],
            ),
          )

          // * rate market
          ,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
               Strings
               .rateMarket.tr(),
                style: TextStyles.textStyleFontLight10lack,
              ),
              RatingBar(
                minRating: 1,
                maxRating: 5,
                
                initialRating: market.rate.toDouble(),
                itemSize: AppSize.s14,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(Icons.star),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ),
                onRatingUpdate: (val) {},
              ),
              Text(
                context.convertDate(market.createdAt),
                style: TextStyles.textStyleFontLight10Grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
