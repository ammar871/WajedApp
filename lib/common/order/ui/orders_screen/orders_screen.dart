import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../market/home/ui/home_market_screen/components/tab_bar_orders_widget.dart';
import '../../../app/data/models/bas_models/tab_bar_item_model.dart';
import 'components/orders_list_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int page = 1;
  int indexTab = 0;

  List<TabBarItemModel> items = [
    TabBarItemModel(title: Strings.newOrder.tr(), index: 0),
    TabBarItemModel(title: Strings.currentOrders.tr(), index: 1),
    TabBarItemModel(title: Strings.inDlivared.tr(), index: 2),
    TabBarItemModel(title: Strings.delivared.tr(), index: 3),
    TabBarItemModel(title: Strings.canclation.tr(), index: -1)
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderCubit>()..getOrders(page, indexTab),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.orders.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          body: DefaultTabController(
            length: 5,
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                return Column(
                  children: [
                    TabBarOrdersWidget(
                        onTap: (index) {
                          indexTab = items[index].index;
                          print(items[index].index);
                          OrderCubit.get(context)
                              .getOrders(page, items[index].index);
                        },
                        list: items),
                    Expanded(
                      child: getBodyOrders(state),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }

  Widget getBodyOrders(OrderState state) {
    switch (state.getOrdersState) {
      case RequestState.loaded:
        return 
        // check list empty
        state.orderResponse!.items.isEmpty
            ? TextListEmpty(text: Strings.noOrders.tr())
            :
         OrdersListWidget(
          orders: state.orderResponse!.items,
        );
      case RequestState.error:
        return const Text("error");
      case RequestState.loading:
        return const CustomCircularProgress();
      default:
        return const Text("error");
    }
  }
}
