import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/user/offers/bloc/offer_cubit/offer_cubit.dart';
import 'package:wajed_app/user/offers/ui/offers_screen/offers_screen.dart';

import '../../../../../core/constants/layout/app_radius.dart';
import '../../../../../core/constants/layout/palette.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/api_constatns.dart';

import '../../../../offers/data/models/offfer_model.dart';

class OffersListWidget extends StatelessWidget {
  final List<OfferModel> offers;
  const OffersListWidget({
    super.key,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 175.h,
        width: context.width,
        child: CarouselSlider(
          items: List.generate(
            offers.length,
            (index) {
              final imageUrl =
                  ApiConstants.baseUrlImages + (offers[index].image);
              return GestureDetector(
                onTap: () {
                  context.navigatePush(BlocProvider(
                      create: (context) => sl<OfferCubit>(),
                      child: OffersScreen(
                          offer: offers[index])));
                },
                child: Container(
                  width: context.width,
                  height: 175.h,
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  decoration: BoxDecoration(
                    color: Palette.kGreyLightColor,
                    borderRadius: AppRadius.r10.r,
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.r10.r,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          options: CarouselOptions(
            autoPlay: true,
            pauseAutoPlayOnTouch: true,
            viewportFraction: 0.9,
          ),
        ));
  }
}
