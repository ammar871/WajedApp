import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/ui/traking_order_screen/traking_order_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';

import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../user/cart/ui/review_order_screen/review_order_screen.dart';
import '../order_details_screen/order_details_screen.dart';

class OrderDetailsMarketScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailsMarketScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderCubit>()..getOrderDetails(orderId),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  Strings.detailsOrder.tr(),
                  style: TextStyles.textStyleFontBold16BlackAppBar,
                ),
                automaticallyImplyLeading: true,
                elevation: 0,
              ),

              ///* accept order bottom sheet
              bottomSheet: state.getOrderDetailsState == RequestState.loading
                  ? const SizedBox()
                  : context.isResturant(currentUser!.user.role)
                      ?
                      // buttons market
                      getBottomSheetMarket(state, context)
                      : getBottomSheetDelivary(state, context),
              body: getBody(state, context));
        },
      ),
    );
  }

  Widget getBody(OrderState state, BuildContext context) {
    switch (state.getOrderDetailsState) {
      case RequestState.loaded:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// *details order
                ///* order id
                RowOrderDetailsWidget(
                  title: Strings.orderNumber.tr(),
                  value: state.orderDetailsResponse!.order.id.toString(),
                ),

                ///* order date
                RowOrderDetailsWidget(
                  title: Strings.dateOrder.tr(),
                  value: context
                      .convertDate(state.orderDetailsResponse!.order.createdAt)
                      .split(" ")[0],
                ),

                ///* order time
                RowOrderDetailsWidget(
                  title:Strings.timeOrder.tr(),
                  value: context
                      .convertTime(state.orderDetailsResponse!.order.createdAt),
                ),

                /// * details market
                ContainerReviewOrder(title: Strings.detailsMarket.tr(), value: ""),

                ///* market name
                RowOrderDetailsWidget(
                  title:Strings.nameMarket.tr(),
                  value: state.orderDetailsResponse!.market.titleAr,
                ),
                RowOrderDetailsWidget(
                  title: Strings.detailsMarket.tr(),
                  value: state.orderDetailsResponse!.market.descAr,
                ),

                RowOrderDetailsWidget(
                  title: Strings.address.tr(),
                  value: state.orderDetailsResponse!.market.addressName,
                ),

                verticalSpace(6.h),
                // * user details
                ContainerReviewOrder(title:Strings.clientOrder.tr(), value: ""),
                //* name
                RowOrderDetailsWidget(
                  title: Strings.theName.tr(),
                  value: state.orderDetailsResponse!.user.fullName,
                ),

                RowOrderDetailsWidget(
                  title:Strings.phone.tr(),
                  value: state.orderDetailsResponse!.user.userName,
                ),

                RowOrderDetailsWidget(
                  title: Strings.address.tr(),
                  value: state.orderDetailsResponse!.address.description,
                ),
                verticalSpace(9.h),

                ContainerReviewOrder(
                  title: Strings.detailsOrder.tr(),
                  value: "${state.orderDetailsResponse!.products.length}${Strings.items}",
                ),

                verticalSpace(12.h),

                ///* cart List
                OrderItemsList(list: state.orderDetailsResponse!.products),

                verticalSpace(12.h),
                // //* payment Method
                ContainerReviewOrder(
                  title:Strings.paymentMethod.tr(),
                  value: payments
                      .firstWhere((element) =>
                          element.id ==
                          state.orderDetailsResponse!.order.payment)
                      .name,
                ),
                verticalSpace(12.h),
                //* copoun
                ContainerReviewOrder(
                  title: Strings.copun.tr(),
                  value: "واجد44",
                ),
                verticalSpace(12.h),
                ContainerReviewOrder(
                  title: Strings.priceOrder.tr(),
                  value: context
                      .toPrice2(state.orderDetailsResponse!.order.productsCost),
                ),
                verticalSpace(12.h),
                ContainerReviewOrder(
                  title: Strings.delivaryCost.tr(),
                  value:
                      context.toPrice2(state.orderDetailsResponse!.order.tax),
                ),

                verticalSpace(12.h),
                //* copoun
                ContainerReviewOrder(
                  title: Strings.total.tr(),
                  textStyle: TextStyles.textStyleFontBold118Black,
                  value: context
                      .toPrice(state.orderDetailsResponse!.order.totalCost),
                ),

                verticalSpace(12.h),
                //* copoun
                ContainerReviewOrder(
                  title:Strings.timeDelivary.tr(),
                  value: state.orderDetailsResponse!.order.notes ?? "",
                ),

                verticalSpace(150.h)
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
  }

  /// * markets buttons
  Widget getBottomSheetMarket(OrderState state, BuildContext context) {
    switch (state.orderDetailsResponse!.order.status) {
      case -1:
        return Container(
          height: 120.h,
          alignment: Alignment.center,
          child: Text(
            Strings.cancledOrder.tr(),
            style: TextStyles.textStyleFontBold20CloseMarket,
          ),
        );
      case 0: // new order
        return Container(
            height: 150.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
            child: Row(
              children: [
                Expanded(
                    child: state.updateOrderState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title:Strings.acceptOrder.tr(),
                            onPressed: () {
                              OrderCubit.get(context).updateOrderStatus(
                                  orderId: orderId, status: 1);
                            },
                            backgroundColor: Palette.restaurantColor,
                          )),
                horizontalSpace(20.h),
                Expanded(
                    child: state.cancelOrderState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: Strings.cancleOrder.tr(),
                            onPressed: () {
                              OrderCubit.get(context).updateOrderStatus(
                                  orderId: orderId, status: -1);
                            },
                            backgroundColor: Palette.kStoreClosedColor,
                          ))
              ],
            ));

      case > 0:

        /// accepted from  market
        return Container(
          height: 150.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
          child: Center(
            child: CustomButton(
              title:Strings.followOrder.tr(),
              onPressed: () {
                context.navigatePush(BlocProvider(
                  create: (context) => sl<OrderCubit>(),
                  child: TrakingOrderScreen(orderId: orderId),
                ));
              },
              backgroundColor: Palette.mainColor,
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }

  /// * delivary buttons
  getBottomSheetDelivary(OrderState state, BuildContext context) {
    switch (state.orderDetailsResponse!.order.status) {
      case -1:
        return Container(
          height: 120.h,
          alignment: Alignment.center,
          child: Text(
           Strings.cancledOrder.tr(),
            style: TextStyles.textStyleFontBold20CloseMarket,
          ),
        );
      case 1: // new order
        return Container(
            height: 150.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
            child: Center(
              child: state.updateOrderState == RequestState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      title:Strings.acceptOrder.tr(),
                      onPressed: () {
                      
                        OrderCubit.get(context).acceptOrderDriver(
                            orderId: state.orderDetailsResponse!.order.id,
                            driverId: driverDetails!.id,context: context);
                      },
                      backgroundColor: Palette.mainColor,
                    ),
            ));

      case > 1:

        /// accepted from  market
        return Container(
          height: 150.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
          child: Center(
            child: CustomButton(
              title:Strings.followOrder.tr(),
              onPressed: () {
                  context.navigatePush(TrakingOrderScreen(orderId: orderId));
              },
              backgroundColor: Palette.mainColor,
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}

class RowOrderDetailsWidget extends StatelessWidget {
  final String title, value;

  const RowOrderDetailsWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width / 3,
          child: Text(
            title,
            style:
                TextStyles.textStyleFontLight12kDarkGrey.copyWith(height: 1.2),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyles.textStyleFontBold118Black,
          ),
        ),
      ],
    );
  }
}
