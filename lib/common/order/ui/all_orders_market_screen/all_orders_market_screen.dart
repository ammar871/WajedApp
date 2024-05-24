import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/app/data/models/bas_models/tab_bar_item_model.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/market/home/ui/home_market_screen/components/tab_bar_orders_widget.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../data/models/order_model.dart';
import 'components/orders_list_widget.dart';

class AllOrdersMarketScreen extends StatefulWidget {
  final int marketId;
  const AllOrdersMarketScreen({super.key, required this.marketId});

  @override
  State<AllOrdersMarketScreen> createState() => _AllOrdersMarketScreenState();
}

class _AllOrdersMarketScreenState extends State<AllOrdersMarketScreen> {
  int currentStaus = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderCubit>()
        ..getOrdersMarket(marketId: marketDetails!.id, page: 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.allOrders.tr(),
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state.getOrdersMarketState == RequestState.loaded) {
              OrderCubit.get(context).orders = state.ordersMarket!.items
                  .where((element) => element.status == 3)
                  .toList();
            }
          },
          builder: (context, state) {
            switch (state.getOrdersMarketState) {
              case RequestState.loaded:
                return DefaultTabController(
                  length: 4,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
                    child: Column(
                      children: [
                        verticalSpace(20.h),
                        Text(
                          Strings.descAllOrders.tr(),
                          style: TextStyles.textStyleFontLight12kDarkGrey,
                        ),

                        /// * tab bar widget
                        TabBarOrdersWidget(
                            list: [
                              TabBarItemModel(
                                  title: Strings.news.tr(), index: 0),
                              TabBarItemModel(
                                  title: Strings.successfuly.tr(), index: 1),
                              TabBarItemModel(
                                  title: Strings.unCopmleted.tr(), index: 2),
                              TabBarItemModel(
                                  title: Strings.faild.tr(), index: 3),
                            ],
                            onTap: (value) {
                              print(value);
                              filterOrders(
                                  value, state.ordersMarket!.items, context);
                            }),

                        // * orders list
                        OrdersListWidget(
                          orders: OrderCubit.get(context).orders,
                        ),
                      ],
                    ),
                  ),
                );
              case RequestState.error:
                return const Text("error");
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              default:
                return const Text("error");
            }
          },
        ),
      ),
    );
  }

  void filterOrders(int value, List<OrderModel> orders, BuildContext context) {
    OrderCubit.get(context).orders = [];
    currentStaus = value;
    //*"غير ناجحة"
    if (value == 3) {
      OrderCubit.get(context).orders =
          orders.where((element) => element.status == -1).toList();
    }

    //* "جديدة"
    else if (value == 0) {
      OrderCubit.get(context).orders = orders
          .where((element) => element.status < 3 && element.status == 0)
          .toList();
    }
    //* "غير مكتملة"
    else if (value == 2) {
      OrderCubit.get(context).orders = orders
          .where((element) => element.status < 3 && element.status > 0)
          .toList();
    }
    //*ناجحة
    else {
      OrderCubit.get(context).orders =
          orders.where((element) => element.status == 3).toList();
    }

    setState(() {});
  }
}
