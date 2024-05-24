
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/driver/data/models/home_response_driver.dart';

import '../../../../common/order/ui/all_orders_market_screen/components/orders_list_widget.dart';
import '../../../../common/order/ui/order_details_market_screenn/order_details_market_screenn.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../user/cart/ui/components/divider_widget.dart';

class OrdersDriverList extends StatelessWidget {
  final List<OrderDriver> orders;
  const OrdersDriverList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? TextListEmpty(text: Strings.noOrders.tr())
        : ListView.separated(
            itemCount: orders.length,
            separatorBuilder: (BuildContext context, int index) =>
                const DividerWidget(
                  hieght: .5,
                  color: Palette.kGreyColor,
                ),
            itemBuilder: (context, index) {
              OrderDriver orderDriver = orders[index];
              return GestureDetector(
                onTap: () {
                  context.navigatePush(
                      OrderDetailsMarketScreen(orderId: orderDriver.order.id));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// * order details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowDetailsMarket(
                            title: Strings.orderNumber.tr(),
                            value: orderDriver.order.id.toString(),
                          ),
                          RowDetailsMarket(
                            title: Strings.date.tr(),
                            value: context
                                .convertDateDay(orderDriver.order.createdAt),
                          ),
                          RowDetailsMarket(
                            title: Strings.time.tr(),
                            value: context
                                .convertTime(orderDriver.order.createdAt),
                          ),
                          RowDetailsMarket(
                            title: Strings.address.tr(),
                            value: orderDriver.address.description,
                          ),
                        ],
                      )

                      /// * address order
                      ,
                      Column(
                        children: [
                          Text(
                            context
                                .getColorOrderStatus(orderDriver.order.status)
                                .name.tr(),
                            style: TextStyles.textStyleFontBold16BlackAppBar
                                .copyWith(
                                    height: 1.2,
                                    color: context
                                        .getColorOrderStatus(
                                            orderDriver.order.status)
                                        .color),
                          ),
                          Text(
                            context.toPrice2(orderDriver.order.totalCost),
                            style: TextStyles.textStyleFontBold27Black.copyWith(
                                height: 1.2,
                                color: Palette.restaurantColor,
                                fontSize: 20.sp),
                          ),
                          verticalSpace(10.h),
                          SizedBox(
                            width: 80.w,
                            height: 40.h,
                            child: CustomButton(
                                title: Strings.details.tr(),
                                onPressed: () {
                                  context.navigatePush(OrderDetailsMarketScreen(
                                      orderId: orderDriver.order.id));
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
