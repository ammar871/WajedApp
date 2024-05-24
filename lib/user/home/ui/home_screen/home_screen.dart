import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/market/data/models/filter_body_request.dart';
import 'package:wajed_app/market/market/ui/all_markets_screen/all_markets_screen.dart';
import 'package:wajed_app/market/market/ui/search_market_screen/search_market_screen.dart';
import 'package:wajed_app/user/home/bloc/home_cubit/home_cubit.dart';
import '../../../../core/common_widgets/home/home_search_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/firebase_manger.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../market/market/bloc/market_cubit/market_cubit.dart';
import 'comonents/app_bar_home_widget.dart';
import 'comonents/fields_list_widget.dart';
import 'comonents/markets_widget.dart';
import 'comonents/offers_list_widget.dart';
import '../../../../core/common_widgets/darwer_widget/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getLocation();
    FCMManger().getMessagesFCM();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..getHomeUser(context: context, userId:currentUser!=null? currentUser!.user.id:""),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          return Scaffold(
            key: scaffolded,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: AppBarHomeWidget(
                  onPressed: () {
                    scaffolded.currentState!.openDrawer();
                  },
                ),
              ),
            ),
            // * darwer
            drawer: DraweWidget(),
            body: getBody(state,ctx: ctx),
          );
        },
      ),
    );
  }

  Widget getBody(HomeState state,{ctx}) {
    switch (state.getHomeState) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.loaded:
        return Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
            child: RefreshIndicator(
              onRefresh: () async {
                HomeCubit.get(ctx).getHomeUser(
                    context: ctx, userId: currentUser!.user.id);
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
                  OffersListWidget(offers: state.homeUserResponse!.offers),

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

      case RequestState.error:
        return const Center(child: Text("Error"));
      case RequestState.pagination:
        return const Center(child: Text("pagination"));
    }
  }
}
