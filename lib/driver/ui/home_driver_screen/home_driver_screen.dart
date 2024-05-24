
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/firebase_manger.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/driver/bloc/cubit/driver_cubit.dart';
import 'package:wajed_app/driver/ui/orders_driver_screen/orders_driver_screen.dart';
import 'package:wajed_app/market/home/ui/home_market_screen/components/tab_bar_orders_widget.dart';
import '../../../common/app/data/models/bas_models/tab_bar_item_model.dart';
import '../../../core/constants/layout/palette.dart';
import '../../../core/enums/loading_status.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/services/services_locator.dart';
import '../../../market/home/ui/home_market_screen/home_market_screen.dart';
import '../../../core/common_widgets/darwer_widget/drawer_widget.dart';
import 'components/app_bar_driver_home_widget.dart';
import 'components/driver_details_widget.dart';
import 'components/orders_driver_list.dart';

class HomeDriverScreen extends StatefulWidget {
  const HomeDriverScreen({super.key});

  @override
  State<HomeDriverScreen> createState() => _HomeDriverScreenState();
}

class _HomeDriverScreenState extends State<HomeDriverScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();

  int currentIndex = 1; // new orders ,2 old orders

  @override
  void initState() {
   
    super.initState();
    getLocation();
    FCMManger().getMessagesFCM();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DriverCubit>()
        ..getHomeDriver(currentUser!.user.id, context: context),
      child: BlocBuilder<DriverCubit, DriverState>(
        builder: (context, state) {
          switch (state.getHomeDriverState) {
            case RequestState.loading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RequestState.loaded:
              return
                  // has accpunt
                  DefaultTabController(
                length: 2,
                child: Scaffold(
                    key: scaffolded,
                    drawer: DraweWidget(),
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(80.h),
                      child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Palette.restaurantColor,
                          elevation: 0,
                          title: AppBarDriverHomeWidget(
                            onTap: () {
                              scaffolded.currentState!.openDrawer();
                            },
                          )),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(25.0).w,
                      child: Column(
                        children: [
                          /// * details account
                          DriverDetailsWidget(
                            driverModel:
                                state.homeDriverResponse!.data!.driver!,
                          ),
                          verticalSpace(30.h),
                          //* Orders
                          TitleOrderWidget(
                            onTap: () {
                              context.navigatePush(const OrdersDriverScreen());
                            },
                          ),

                          verticalSpace(15.h),
                          TabBarOrdersWidget(
                              onTap: (int index) {
                                // currentIndex = index;
                                // setState(() {});
                              },
                              list: [
                                TabBarItemModel(
                                    title: Strings.newOrders.tr(), index: 1),
                                TabBarItemModel(
                                    title: Strings.cureentOrders.tr(), index: 2)
                              ]),
                          verticalSpace(15.h),
                          Expanded(
                            child: TabBarView(children: [
                              // * new orders
                              OrdersDriverList(
                                  orders: state
                                      .homeDriverResponse!.data!.currentOrders),

                              // * my orders
                              OrdersDriverList(
                                  orders:
                                      state.homeDriverResponse!.data!.myOrders)
                            ]),
                          )
                        ],
                      ),
                    )),
              );

            case RequestState.error:
              return Scaffold(
                body: Center(
                  child: Text('حدث خطأ ما'.tr()),
                ),
              );

            case RequestState.pagination:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

