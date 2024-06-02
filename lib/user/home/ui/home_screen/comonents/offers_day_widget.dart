import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';

import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../offers/bloc/offer_cubit/offer_cubit.dart';
import '../../../../offers/data/models/offfer_model.dart';
import '../../../../offers/ui/offers_screen/offers_screen.dart';

class OffersDayWidget extends StatelessWidget {
  final List<OfferModel> offers;
  const OffersDayWidget({
    super.key,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            Strings.offersDay.tr(),
            style: TextStyles.textStyleFontBold20Black,
          )
        ]),
        verticalSpace(15.h),
        Container(
          height: 150.h,
          child: ListView.builder(
              itemCount: offers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                OfferModel offerModel = offers[index];
                return GestureDetector(
                  onTap: () {
                    context.navigatePush(BlocProvider(
                        create: (context) => sl<OfferCubit>(),
                        child: OffersScreen(
                          offer: offerModel,
                        )));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: .5,
                          color: Colors.grey[300]!,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: ImageNetworkWidget(
                        imageUrl: offerModel.icon!,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
