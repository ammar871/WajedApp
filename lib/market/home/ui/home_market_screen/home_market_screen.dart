import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/app/data/models/bas_models/tab_bar_item_model.dart';
import 'package:wajed_app/common/order/ui/all_orders_market_screen/all_orders_market_screen.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import 'package:wajed_app/market/home/ui/home_market_screen/components/tab_bar_orders_widget.dart';
import '../../../../core/enums/loading_status.dart';
import '../../data/models/home_market_response.dart';
import 'components/conters_details_widget.dart';
import 'components/details_market_widget.dart';
import 'components/item_order_home_market_widget.dart';

class HomeMarketScreen extends StatefulWidget {
  const HomeMarketScreen({super.key});

  @override
  State<HomeMarketScreen> createState() => _HomeMarketScreenState();
}

class _HomeMarketScreenState extends State<HomeMarketScreen> {
  int currentStaus = 0;
  List<OrderRsponseMarket> ordrers = [];

  List<TabBarItemModel> itemsTabBar = [
    TabBarItemModel(title: Strings.all.tr(), index: -1),
     TabBarItemModel(title: Strings.news.tr(), index: 0),
    TabBarItemModel(title: Strings.procceing.tr(), index: 1),
    TabBarItemModel(title: Strings.complatedTab.tr(), index: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeMarketCubit, HomeMarketState>(
      listener: (context, state) {
        if (state.getHomeMarketState == RequestState.loaded) {}
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// * details Market
                  DetailsMarketWidget(
                      market: state.homeResponseMarket!.data!.market),
                  verticalSpace(20.h),
                  // * Counters Details
                  ContersDetailsWidget(
                      homeResponseMarket: state.homeResponseMarket!),
                  verticalSpace(20.h),

                  /// * orders
                  TitleOrderWidget(
                    onTap: () {
                      context.navigatePush(AllOrdersMarketScreen(
                          marketId: state.homeResponseMarket!.data!.market.id));
                    },
                  ),

                  // tab bar orders

                  TabBarOrdersWidget(
                      list: itemsTabBar,
                      onTap: (value) {
                        HomeMarketCubit.get(context).ordrers = [];
                        currentStaus = itemsTabBar[value].index;
                        print(currentStaus);
                        /// * all 
                        if (currentStaus == -1) {
                          HomeMarketCubit.get(context).ordrers =
                              state.homeResponseMarket!.data!.lastOrders;
                        } 
                        /// * news
                        else if (currentStaus == 0) {
                          HomeMarketCubit.get(context).ordrers = state
                              .homeResponseMarket!.data!.lastOrders
                              .where((element) =>
                                  element.order.status == 0)
                              .toList();
                        } 
                        // * prossing
                          else if (currentStaus == 1) {
                          HomeMarketCubit.get(context).ordrers = state
                              .homeResponseMarket!.data!.lastOrders
                              .where((element) =>
                                  element.order.status >= 1&& element.order.status<3)
                              .toList();
                        } 
                        /// * delivared
                        else {
                          HomeMarketCubit.get(context).ordrers = state
                              .homeResponseMarket!.data!.lastOrders
                              .where((element) =>
                                  element.order.status == 3)
                              .toList();
                        }

                        setState(() {});
                      }),
                  verticalSpace(20.h),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: HomeMarketCubit.get(context).ordrers.length,
                      itemBuilder: (ctx, index) {
                        OrderRsponseMarket orderRsponseMarket =
                            HomeMarketCubit.get(context).ordrers[index];

                        return ItemOrderHomeMarketWidget(
                            orderRsponseMarket: orderRsponseMarket);
                      })
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}

class TitleOrderWidget extends StatelessWidget {
  final VoidCallback onTap;
  const TitleOrderWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.recentOrders.tr(),
          style: TextStyles.textStyleFontBold20Black,
        ),
        MaterialButton(
            onPressed: onTap,
            child: Row(
              children: [
                Text(
                  Strings.all.tr(),
                  style: TextStyles.textStyleFontBold118Black,
                ),
                horizontalSpace(10.r),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 20.w,
                )
              ],
            ))
      ],
    );
  }
}
