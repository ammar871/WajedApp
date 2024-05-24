import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/ui/order_details_market_screenn/order_details_market_screenn.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/ui/product_details_screen/product_details_screen.dart';
import 'package:wajed_app/core/extension/app_extensions.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/theming/styles.dart';
import '../../../data/models/home_market_response.dart';

class ItemOrderHomeMarketWidget extends StatelessWidget {
  final OrderRsponseMarket orderRsponseMarket;
  const ItemOrderHomeMarketWidget({
    super.key,
    required this.orderRsponseMarket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      // height: 360.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            // height: double.infinity,
            // width: double.infinity,
            padding: const EdgeInsets.all(15).w,
            margin: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffefefef)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                //* number order
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          Strings.orderNo.tr(),
                          style: TextStyles.textStyleFontBold20Black,
                        ),
                        horizontalSpace(30.w),
                        Text(
                          orderRsponseMarket.order.id.toString(),
                          style: TextStyles.textStyleFontBold20Black,
                        ),
                      ],
                    ),
                    Text(
                      context.toPrice(orderRsponseMarket.order.totalCost),
                      style: TextStyles.textStyleFontBold20Black,
                    ),
                  ],
                ),

                /// * date
                Row(
                  children: [
                    Text(
                      context.convertDate(orderRsponseMarket.order.createdAt),
                      style: TextStyles.textStyleFontLight10Grey,
                    )
                  ],
                ),
                verticalSpace(10.h),
                // * products
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderRsponseMarket.orderItems.length,
                  itemBuilder: (context, index) {
                    OrderItemResponseMarket orderItem =
                        orderRsponseMarket.orderItems[index];
                    return GestureDetector(
                      onTap: () {
                        context.navigatePush(BlocProvider(
                          create: (context) => sl<ProductCubit>(),
                          child: ProductDetailsScreen(
                              productId: orderItem.orderItem.productId),
                        ));
                      },
                      child: Row(
                        children: [
                          // * image product
                          Container(
                            height: 75.h,
                            width: 75.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.r),
                                image: DecorationImage(
                                    image: NetworkImage(context.getImageURL(
                                        context.getImageProduct(orderItem
                                            .productResponse
                                            .product
                                            .imageUrl))),
                                    fit: BoxFit.fill)),
                          ),
                          horizontalSpace(10.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAraic()
                                      ? orderItem.productResponse.product.nameAr
                                      : orderItem
                                          .productResponse.product.nameEng,
                                  maxLines: 1,
                                  style: TextStyles.textStyleFontBold20Black
                                      .copyWith(
                                          overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),

                          /// * price order item
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.toPrice2(orderItem.orderItem.cost),
                                maxLines: 1,
                                style: TextStyles.textStyleFontBold20Black
                                    .copyWith(
                                        height: 1.2,
                                        overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                "${orderItem.orderItem.quantity}x",
                                maxLines: 1,
                                style: TextStyles
                                    .textStyleFontRegular16greyColor
                                    .copyWith(overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                verticalSpace(20.h),

                /// * prices order
                RowPricesOrderWidget(
                  title: Strings.delivaryCost.tr(),
                  value: context.toPrice(orderRsponseMarket.order.deliveryCost),
                ),
                RowPricesOrderWidget(
                  title: Strings.tax.tr(),
                  value: context.toPrice(orderRsponseMarket.order.tax),
                ),
                RowPricesOrderWidget(
                  title: Strings.total.tr(),
                  textStyle: TextStyles.textStyleFontBold12bblack,
                  value: context.toPrice(orderRsponseMarket.order.totalCost),
                )
              ],
            ),
          )
          //* status Order
          ,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 30.h,
              width: 135.w,
              decoration: BoxDecoration(
                  color: context
                      .getColorOrderStatus(orderRsponseMarket.order.status)
                      .color,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Center(
                child: Text(
                  context
                      .getColorOrderStatus(orderRsponseMarket.order.status)
                      .name.tr(),
                  style: TextStyles.textStyleFontRegular10WhiteColor,
                ),
              ),
            ),
          )
          //* display Order
          ,
          Positioned(
            bottom: 0,
            left: 140.w,
            right: 140.w,
            child: GestureDetector(
              onTap: () {
                context.navigatePush(OrderDetailsMarketScreen(
                    orderId: orderRsponseMarket.order.id));
              },
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Palette.fontGreyColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: Text(
                   Strings.display.tr(),
                    style: TextStyles.textStyleFontRegular10WhiteColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowPricesOrderWidget extends StatelessWidget {
  final String title, value;
  final TextStyle? textStyle;
  const RowPricesOrderWidget({
    super.key,
    required this.title,
    required this.value,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle ?? TextStyles.textStyleFontRegular12fontGreyColor,
        ),
        Text(
          value,
          style: textStyle ?? TextStyles.textStyleFontRegular12fontGreyColor,
        )
      ],
    );
  }
}
