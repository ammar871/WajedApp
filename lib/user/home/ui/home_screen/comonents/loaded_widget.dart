import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

import '../../../../../core/common_widgets/home/home_search_bar.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/app_model.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../market/market/bloc/market_cubit/market_cubit.dart';
import '../../../../../market/market/data/models/filter_body_request.dart';
import '../../../../../market/market/ui/all_markets_screen/all_markets_screen.dart';
import '../../../../../market/market/ui/search_market_screen/search_market_screen.dart';
import '../../../bloc/home_cubit/home_cubit.dart';
import 'fields_list_widget.dart';
import 'markets_widget.dart';
import 'offers_day_widget.dart';

class LoadedWidget extends StatelessWidget {
  final HomeState state;
  const LoadedWidget({
    super.key,
    required this.context, required this.state,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
        child: RefreshIndicator(
          onRefresh: () async {
            HomeCubit.get(context)
                .getHomeUser(context: context, userId: currentUser!.user.id);
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              /// app bar home
    
              verticalSpace(30.h),
    
              FieldsListWidget(fields: state.homeUserResponse!.fields),
    
              verticalSpace(30.h),
    
              /// search widget
              GestureDetector(
                  onTap: () {
                    /// * go to search page
                    context.navigatePush(BlocProvider(
                      create: (context) => sl<MarketCubit>(),
                      child: const SearchMarketScreen(),
                    ));
                  },
                  child: const HomeSearchBar(
                    enable: false,
                  )),
    
              verticalSpace(27.h),
    
              /// offers widget
              if(state.homeUserResponse!.offers.isNotEmpty)
              OffersDayWidget(offers:state.homeUserResponse!.offers),
            
               // OffersListWidget(offers: state.homeUserResponse!.offers),
    
              verticalSpace(27.h),
    
              /// markets widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.neerMarkts.tr(),
                    style: TextStyles.textStyleFontBold20Black,
                  ),
    
                  /// * go to all markets
                  MaterialButton(
                      onPressed: () {
                        context.navigatePush(BlocProvider(
                          create: (context) => sl<MarketCubit>(),
                          child: AllMarketsScreen(
                            filterBodyRequest: FilterBodyRequest(
                                page: 1, userId: currentUser!.user.id),
                          ),
                        ));
                      },
                      child: Row(
                        children: [
                          Text(
                            Strings.all.tr(),
                            style: TextStyles.textStyleFontBold20mainColor,
                          ),
                          horizontalSpace(10.w),
                          Icon(Icons.arrow_forward,
                              size: 20.w, color: Palette.mainColor)
                        ],
                      ))
                ],
              ),
              verticalSpace(18.h),
              MarketsWidget(markets: state.homeUserResponse!.markets)
            ]),
          ),
        ));
  }
}

