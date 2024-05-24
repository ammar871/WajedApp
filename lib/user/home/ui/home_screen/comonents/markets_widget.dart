import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/icon_fav_widget.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/extension/app_extensions.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/market/ui/market_details_screen/market_details_screen.dart';
import 'package:wajed_app/user/favoraite/bloc/favoraite_cubit/favoraite_cubit.dart';
import 'package:wajed_app/user/favoraite/data/models/add_fav_body.dart';

import '../../../../../core/constants/layout/app_radius.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../market/market/data/models/market_model.dart';

class MarketsWidget extends StatelessWidget {
  final List<MarketModel> markets;
  const MarketsWidget({
    super.key,
    required this.markets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: markets.length,
      itemBuilder: (context, index) {
        return MarketCard(market: markets[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }
}

class MarketCard extends StatelessWidget {
  final bool? isFav;
  const MarketCard(
      {Key? key,
      // ignore: unused_element
      this.hasDivider = false,
      required this.market,
      this.isClickable = true,
      this.isFav = false})
      : super(key: key);

  final bool hasDivider;
  final MarketModel? market;
  final bool isClickable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigatePush(MarketDetailsScreen(
          marketId: market!.id,
        ));
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Container(
                  width: context.getHomeCardSize(),
                  height: context.getHomeCardSize(),
                  padding: const EdgeInsets.all(AppSize.s2),
                  margin: const EdgeInsets.symmetric(vertical: AppSize.s5),
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: AppRadius.r10.r,
                    boxShadow: const [
                      BoxShadow(
                        color: Palette.kShadowColor,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.r10,
                    child: CachedNetworkImage(
                      imageUrl: context.getImageURL(market!.imageLogo),
                      errorWidget: (context, url, error) {
                        return const SizedBox();
                      },
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Store details
                Expanded(
                  child: Container(
                    // height: getHomeCardSize(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s10,
                      // vertical: AppSize.s5,
                    ),
                    decoration: const BoxDecoration(
                      // color: Colors.blueGrey,
                      borderRadius: AppRadius.r10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFav!
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      FavoraiteCubit.get(context).addFavoraites(
                                          AddFavBody(
                                              currentUser!.user.id, market!.id));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20.w,
                                      color: Colors.red,
                                    ))
                                : IconFavWidget(marketId: market!.id),
                          ],
                        ),
                        verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                isAraic() ? market!.titleAr : market!.titleEng),
                            RatingBar(
                              minRating: 1,
                              maxRating: 5,
                              initialRating: market!.rate.toDouble(),
                              itemSize: AppSize.s16,
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
                          ],
                        ),
                        verticalSpace(3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isAraic() ? market!.descAr : market!.descEng,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Palette.kDarkGrey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            /// km & store status
                            Row(
                              children: [
                                Container(
                                  // width: AppSize.s50,
                                  // height: AppSize.s25.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s10.w,
                                    // vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFB7B7B7),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.s8.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      context.toDistance(market!.distance),
                                      style: context.bodyS,
                                    ),
                                  ),
                                ),
                                SizedBox(width: AppSize.s5.w),
                                Container(
                                  width: AppSize.s70.w,
                                  // height: AppSize.s20,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s5.w,
                                    // vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: market!.status == 0
                                        ? Palette.mainColor
                                        : Palette.kStoreClosedColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.s10.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      // "مغلق",
                                      market!.status == 0
                                          ? Strings.opend.tr()
                                          : Strings.closed.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Palette.white,
                                            height: 1.5,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // End
                          ],
                        ),
                        verticalSpace(3.h),

                        /// Delivery Time, Delivery fee and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // "توصيل خلال 60 د",
                              market!.titleAr.toString(),
                              // overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              "توصيل مجاني",
                              style: context.bodyS,
                              // overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "الحد الادني 60 رس",
                              style: context.bodyS,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (hasDivider)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getHorizontalPadding(),
                ),
                child: const Divider(
                  color: Palette.kDividerColor,
                  // thickness: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
