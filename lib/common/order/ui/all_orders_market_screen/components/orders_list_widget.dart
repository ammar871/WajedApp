import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/ui/order_details_market_screenn/order_details_market_screenn.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../../core/common_widgets/rating_bar_widget.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../user/cart/ui/components/divider_widget.dart';
import '../../../data/models/order_model.dart';

class OrdersListWidget extends StatelessWidget {
  final List<OrderModel> orders;
  const OrdersListWidget({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: orders.isEmpty
          ? TextListEmpty(text: Strings.noOrders.tr())
          : ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = orders[index];
                return GestureDetector(
                  onTap: () {
                   
                    context.navigatePush(
                        OrderDetailsMarketScreen(orderId: orderModel.id));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// * order details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowDetailsMarket(
                              title: Strings.orderNumber.tr(),
                              value: orderModel.id.toString(),
                            ),
                            RowDetailsMarket(
                              title:Strings.date.tr(),
                              value:
                                  context.convertDateDay(orderModel.createdAt),
                            ),
                            RowDetailsMarket(
                              title: Strings.time.tr(),
                              value: context.convertTime(orderModel.createdAt),
                            ),
                          ],
                        )

                        /// * Rate order
                        ,
                        Column(
                          children: [
                            RatingBarWidget(rate: orderModel.rate, size: 16.w),
                            verticalSpace(10.h),
                            Text(
                              context.toDoube(orderModel.totalCost),
                              style: TextStyles.textStyleFontBold27Black
                                  .copyWith(height: 1.2),
                            ),
                            Text(Strings.cruncy.tr(),
                                style: TextStyles.textStyleFontLight10Grey
                                    .copyWith(height: 1.2))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const DividerWidget(
                hieght: .5,
                color: Palette.kGreyColor,
              ),
            ),
    );
  }
}

class RowDetailsMarket extends StatelessWidget {
  final String title, value;
  const RowDetailsMarket({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyles.textStyleFontRegular12fontGreyColor,
          ),
        ),
        horizontalSpace(20.w),
        SizedBox(
          width: context.width/2.5,
          child: Text(
            value,
            style: TextStyles.textStyleFontBold12bblack,
          ),
        ),
      ],
    );
  }
}
