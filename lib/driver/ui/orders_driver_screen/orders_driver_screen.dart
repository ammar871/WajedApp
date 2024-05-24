import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/app/data/models/bas_models/tab_bar_item_model.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/driver/data/models/home_response_driver.dart';
import 'package:wajed_app/market/home/ui/home_market_screen/components/tab_bar_orders_widget.dart';
import '../../../core/enums/loading_status.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utils/strings.dart';
import '../home_driver_screen/components/orders_driver_list.dart';


class OrdersDriverScreen extends StatefulWidget {
  const OrdersDriverScreen({super.key});

  @override
  State<OrdersDriverScreen> createState() => _OrdersDriverScreenState();
}

class _OrdersDriverScreenState extends State<OrdersDriverScreen> {
  List<TabBarItemModel> tabItems = [
    TabBarItemModel(title: Strings.allOrders.tr(), index: 0),
     TabBarItemModel(title: Strings.news.tr(), index: 1),
    TabBarItemModel(title: Strings.successfuly.tr(), index: 2),
    TabBarItemModel(title: Strings.faild.tr(), index: 3),
  ];
  int currentStats = 0;
  List<OrderDriver> orders = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrderCubit>()..getOrdersByDriverId(driverDetails!.id, 1),
      child: DefaultTabController(
        length:4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
             Strings.allOrders.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          body: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              /// * make swich
              switch (state.getOrdersState) {
                case RequestState.loading:
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case RequestState.loaded:
                  return Column(
                    children: [
                      TabBarOrdersWidget(
                          onTap: (value) {
                            currentStats = tabItems[value].index;
                            setState(() {});
                          },
                          list: tabItems),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0).w,
                            child: TabBarView(
                                                  children: [
                            //* all
                            OrdersDriverList(
                                orders: state.orderDriverResponse!.items),

                                //*current
                            OrdersDriverList(
                                orders: state.orderDriverResponse!.items.where((element) => 
                                element.order.status == 1).toList()),
                            //* successfluy
                            OrdersDriverList(
                                orders: state.orderDriverResponse!.items.where((element) => 
                                element.order.status == 3).toList()),
                          
                            /// * failed
                            OrdersDriverList(
                                orders: state.orderDriverResponse!.items
                                    .where(
                                        (element) => element.order.status >1&&element.order.status <3)
                                    .toList())
                                                  ],
                                                ),
                          ))
                    ],
                  );

                case RequestState.error:
                  return  Scaffold(
                    body: Center(
                      child: Text(Strings.someError.tr()),
                    ),
                  );
                case RequestState.pagination:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
