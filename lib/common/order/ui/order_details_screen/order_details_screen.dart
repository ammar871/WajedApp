import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/data/models/order_response.dart';
import 'package:wajed_app/common/order/ui/order_details_screen/components/stepper_widget.dart';
import 'package:wajed_app/common/order/ui/orders_screen/components/orders_list_widget.dart';
import 'package:wajed_app/common/order/ui/traking_order_screen/traking_order_screen.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/ui/product_details_screen/product_details_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';

import 'package:wajed_app/market/market/ui/market_details_screen/market_details_screen.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../user/cart/ui/review_order_screen/review_order_screen.dart';
import '../../data/models/order_details_response.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    OrderCubit.get(context).getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
             Strings.invoci.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            horizontalSpace(20.w),
            Text(
              widget.orderId.toString(),
              style: TextStyles.textStyleFontBold16OrangeColor,
            ),
          ],
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            switch (state.getOrderDetailsState) {
              case RequestState.loaded:
                return Column(
                  children: [
                    // * card Order
                    GestureDetector(
                      onTap: () {
                        context.navigatePush(MarketDetailsScreen(
                            marketId:
                                state.orderDetailsResponse!.market.id));
                      },
                      child: OrderListItem(
                          orderResponse: OrderUserData(
                              market: state.orderDetailsResponse!.market,
                              order: state.orderDetailsResponse!.order)),
                    ),
                    verticalSpace(10.h),
                    //* stepper
                    //* state.orderDetailsResponse!.order.status == -1 ( canceled Order )
                    state.orderDetailsResponse!.order.status == -1
                        ? const SizedBox()
                        : StepperWidget(
                            statuse: state.orderDetailsResponse!.order.status),

                    verticalSpace(30.h),

                    /// *details order
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //* deleviary to
                          ContainerReviewOrder(
                            title: Strings.delivaryTo.tr(),
                            value: state.orderDetailsResponse!.address.name,
                          ),

                          verticalSpace(9.h),
                          //* count items cart
                          ContainerReviewOrder(
                            title:Strings.detailsOrder.tr(),
                            value:
                                "${state.orderDetailsResponse!.products.length}"+Strings.items.tr(),
                          ),
                          verticalSpace(12.h),

                          ///* cart List
                          OrderItemsList(
                              list: state.orderDetailsResponse!.products),

                          verticalSpace(12.h),
                          //* payment Method
                          ContainerReviewOrder(
                            title: Strings.paymentMethod.tr(),
                            value: payments
                                .firstWhere((element) =>
                                    element.id ==
                                    state.orderDetailsResponse!.order.payment)
                                .name,
                          ),
                          verticalSpace(12.h),
                          //* copoun
                          ContainerReviewOrder(
                            title:Strings.copun.tr(),
                            value: "واجد44",
                          ),
                          verticalSpace(12.h),
                          ContainerReviewOrder(
                            title: Strings.priceOrder.tr(),
                            value: context.toPrice2(
                                state.orderDetailsResponse!.order.productsCost),
                          ),
                          verticalSpace(12.h),
                          ContainerReviewOrder(
                            title:Strings.delivaryCost.tr(),
                            value: context.toPrice2(
                                state.orderDetailsResponse!.order.tax),
                          ),

                          verticalSpace(12.h),
                          //* copoun
                          ContainerReviewOrder(
                            title: Strings.total.tr(),
                            textStyle: TextStyles.textStyleFontBold118Black,
                            value: context.toPrice(
                                state.orderDetailsResponse!.order.totalCost),
                          ),

                          verticalSpace(12.h),
                          //* copoun
                          ContainerReviewOrder(
                            title:Strings.timeDelivary.tr(),
                            value:
                                state.orderDetailsResponse!.order.notes ?? "",
                          ),

                          verticalSpace(100.h),
                        ],
                      ),
                    ))

                    // * traking order
                    ,
                    state.orderDetailsResponse!.order.status == -1 ||
                            state.orderDetailsResponse!.order.status == 3
                        ? const SizedBox()
                        : SizedBox(
                            height: 90.h,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                      title: Strings.followOrder.tr(),
                                      onPressed: () {
                                        context.navigatePush(TrakingOrderScreen(
                                            orderId: widget.orderId));
                                      }),
                                ),
                                horizontalSpace(
                                    state.orderDetailsResponse!.order.status ==
                                            0
                                        ? 20.w
                                        : 0),
                                state.orderDetailsResponse!.order.status == 0
                                    ? Expanded(
                                        child: state.cancelOrderState ==
                                                RequestState.loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CustomButton(
                                                title: Strings.cancltaionOrder.tr(),
                                                backgroundColor:
                                                    Palette.kStoreClosedColor,
                                                onPressed: () {
                                                  OrderCubit.get(context)
                                                      .updateOrderStatus(
                                                          orderId:
                                                              widget.orderId,
                                                          status: -1);
                                                }),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                  ],
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
}

class OrderItemsList extends StatelessWidget {
  final List<OrderItemResponse> list;
  const OrderItemsList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        OrderItemResponse orderItem = list[index];
        return GestureDetector(
          onTap: () {
            context.navigatePush(BlocProvider(
              create: (context) => sl<ProductCubit>(),
              child: ProductDetailsScreen(productId: orderItem.cart.productId),
            ));
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              width: double.infinity,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     isAraic()? orderItem.product.nameAr : orderItem.product.nameEng,
                      maxLines: 1,
                      style: TextStyles.textStyleFontBold16greyColor
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      "x${orderItem.cart.quantity}",
                      style: TextStyles.textStyleFontBold20OrangeColor,
                    ),
                  ],
                ),
                verticalSpace(8.h),
                Row(
                  children: orderItem.options!
                      .map((e) => Text(
                           isAraic()? e.nameAr : e.nameEng,
                            style: TextStyles.textStyleFontRegular14greyColor
                                .copyWith(height: 1.2),
                          ))
                      .toList(),
                ),
                verticalSpace(8.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.toPrice(orderItem.cart.cost),
                        style: TextStyles.textStyleFontRegular14greyColor
                            .copyWith(height: 1.2),
                      ),
                    ])
              ])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
