import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/user/home/ui/home_screen/comonents/markets_widget.dart';
import 'package:wajed_app/user/offers/bloc/offer_cubit/offer_cubit.dart';

import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/strings.dart';
import '../../../data/models/offfer_model.dart';

class LoadedOffersWidget extends StatelessWidget {
  final OfferState state;
  final OfferModel offer;
  const LoadedOffersWidget({
    super.key,
    required this.state, required this.offer,
  });

  

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0.h,
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          snap: false,
          leading: BackButton(),
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              title: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.green, width: 1))),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 15.w,
                    ),
                    horizontalSpace(10.w),
                    Expanded(
                        child: Text(
                      Strings.searchToMarket,
                      style: TextStyles.textStyleFontBold12kDarkGrey,
                    ))
                  ],
                ),
              ),
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ImageNetworkWidget(
                  imageUrl: offer.image,
                  height: 250.h,
                  width: double.infinity,
                ),
              )),
        ),
        SliverList.builder(
            itemCount: state.marketsByOfferId!.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                child: MarketCard(
                  market: state.marketsByOfferId!.items[index],
                ),
              );
            })
      ],
    );
  }
}
