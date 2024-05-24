import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/data/models/add_order_body.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/cart/data/models/cart_model.dart';
import 'package:wajed_app/user/cart/data/models/payment_method_model.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/styles.dart';

class ReviewOrderScreen extends StatelessWidget {
  final AddressModel address;
  final CartResponse cartResponse;
  final String time;
  final PaymentMethodModel currentPayMent;

  const ReviewOrderScreen(
      {super.key,
      required this.address,
      required this.time,
      required this.cartResponse,
      required this.currentPayMent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
           Strings.reviewOrder.tr(),
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        bottomSheet: BlocProvider(
          create: (context) => sl<OrderCubit>(),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return Container(
             
                margin: EdgeInsets.symmetric(horizontal: 30.w,vertical: 30.h),
                child: CustomButton(
                    title:Strings.complateOrder.tr(),
                    onPressed: () {
                      OrderCubit.get(context).addOrder(AddOrderBody(
                          userId: currentUser!.user.id,
                          marketId: cartResponse.carts[0].product.marketId,
                          addressId: currentDefulteAddress!.id,
                          payment: currentPayMent.id,
                          notes: time), context,);
                    }),
              );
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, top: 30.w, bottom: 20.w),
            child: SingleChildScrollView(
                child: Column(children: [
              //* deleviary to
              ContainerReviewOrder(
                title:Strings.delivaryTo.tr(),
                value: address.name,
              ),

              verticalSpace(9.h),
              //* count items cart
              ContainerReviewOrder(
                title: Strings.detailsOrder.tr(),
                value: "${cartResponse.carts.length} ${Strings.items.tr()}",
              ),
              verticalSpace(12.h),

              ///* cart List
              CartsReviewWidget(cartResponse: cartResponse),

              verticalSpace(12.h),
              //* payment Method
              ContainerReviewOrder(
                title: Strings.paymentMethod.tr(),
                value: currentPayMent.name,
              ),

              verticalSpace(12.h),
              //* copoun
              ContainerReviewOrder(
                title: Strings.copun.tr(),
                value: "واجد44",
              ),

              verticalSpace(12.h),
              //* copoun
              ContainerReviewOrder(
                title: Strings.total.tr(),
                textStyle: TextStyles.textStyleFontBold118Black,
                value: context.toPrice(cartResponse.totalCost),
              ),

              verticalSpace(12.h),
              //* copoun
              ContainerReviewOrder(
                title: Strings.timeDelivary.tr(),
                value: time,
              ),

              verticalSpace(100.h),
            ]))));
  }
}

class CartsReviewWidget extends StatelessWidget {
  const CartsReviewWidget({
    super.key,
    required this.cartResponse,
  });

  final CartResponse cartResponse;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: cartResponse.carts.length,
      itemBuilder: (ctx, index) {
        CartDeatails cart = cartResponse.carts[index];
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            width: double.infinity,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   isAraic()? cart.product.nameAr: cart.product.nameEng,
                    maxLines: 1,
                    style: TextStyles.textStyleFontBold16greyColor
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    "x${cart.cart.quantity}",
                    style: TextStyles.textStyleFontBold20OrangeColor,
                  ),
                ],
              ),
              verticalSpace(8.h),
              Row(
                children: cart.options
                    .map((e) => Text(
                         isAraic()? e.nameAr: e.nameEng,
                          style: TextStyles.textStyleFontRegular14greyColor
                              .copyWith(height: 1.2),
                        ))
                    .toList(),
              ),
              verticalSpace(8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  context.toPrice(cart.cart.cost),
                  style: TextStyles.textStyleFontRegular14greyColor
                      .copyWith(height: 1.2),
                ),
              ])
            ]));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class ContainerReviewOrder extends StatelessWidget {
  final String title, value;
  final TextStyle? textStyle;
  const ContainerReviewOrder({
    super.key,
    required this.title,
    required this.value,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0.r),
          color: Palette.kStepperLineInactiveColor),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: textStyle ?? TextStyles.textStyleFontBold16greyColor,
          )),
          Expanded(
              child: Text(
            value,
            style: textStyle ?? TextStyles.textStyleFontBold16greyColor,
          ))
        ],
      ),
    );
  }
}
