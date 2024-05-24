import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/ui/order_details_screen/order_details_screen.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/rates/bloc/rate_cubit/rate_cubit.dart';
import 'package:wajed_app/user/rates/data/models/add_rate_body_model.dart';
import '../../../../../core/common_widgets/circular_progress.dart';
import '../../../../../core/common_widgets/custom_button.dart';
import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/enums/loading_status.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../address/ui/addresses_screen/components/container_check_address.dart';
import '../../../data/models/order_response.dart';
import 'container_re_add_order_widget.dart';

class OrdersListWidget extends StatelessWidget {

  final List<OrderUserData> orders;
  const OrdersListWidget({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
      itemCount: orders.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        OrderUserData orderResponse = orders[index];
        return GestureDetector(
            onTap: () {
              context.navigatePush(BlocProvider(
                create: (context) => sl<OrderCubit>(),
                child: OrderDetailsScreen(orderId: orderResponse.order.id),
              ));
            },
            child: OrderListItem(orderResponse: orderResponse));
      },
    );
  }
}

class OrderListItem extends StatefulWidget {
  OrderListItem({
    super.key,
    required this.orderResponse,
  });

  final OrderUserData orderResponse;

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  final _controllerComment = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _controllerComment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // OrderStatusModel orderStatusModel =
    //     context.getOrderStatus();
    return Container(
      height: 150.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0.r),
        color: const Color(0xffffffff),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerCheckAddress(
              color: context
                  .getColorOrderStatus(widget.orderResponse.order.status)
                  .color),
          horizontalSpace(5.w),
          ImageNetworkWidget(
            imageUrl: widget.orderResponse.market.imageLogo,
            height: 70.w,
            width: 70.w,
            fit: BoxFit.contain,
          ),
          horizontalSpace(10.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                isAraic()
                    ? widget.orderResponse.market.titleAr
                    : widget.orderResponse.market.titleEng,
                style: TextStyles.textStyleFontBold16OrangeColor,
              ),
              Text(
                context
                    .getColorOrderStatus(widget.orderResponse.order.status)
                    .name,
                style: TextStyles.textStyleFontRegular16greyColor.copyWith(
                    color: context
                        .getColorOrderStatus(widget.orderResponse.order.status)
                        .color),
              ),
              // * date order
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      context.convertDate(widget.orderResponse.order.createdAt),
                      style: TextStyles.textStyleFontReqluar12kDarkGrey),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15.w,
                      color: Colors.black.withOpacity(.5),
                    ),
                  )
                ],
              )
              // * order number
              ,
              Row(
                children: [
                  Text(Strings.orderNumber.tr(),
                      style: TextStyles.textStyleFontReqluar12kDarkGrey),
                  horizontalSpace(30.w),
                  Text(widget.orderResponse.order.id.toString(),
                      style: TextStyles.textStyleFontReqluar12kDarkGrey),
                ],
              )
              // * re add and rate order
              ,
              widget.orderResponse.order.status != 3
                  ? const SizedBox()
                  : Row(
                      children: [
                        ContainerReAddOrderWidget(
                          onPressed: () {
                            OrderCubit.get(context).reAddOrder(
                                widget.orderResponse.order.id,
                                1,0,
                                context: context);
                          },
                          icon: "assets/icons/reorder.svg",
                          title: Strings.reOrder.tr(),
                        ),
                        horizontalSpace(30.w),
                        ContainerReAddOrderWidget(
                          onPressed: () {
                            rateOrder(context, widget.orderResponse.order.id);
                          },
                          icon: "assets/icons/rate.svg",
                          title: Strings.rateOrder.tr(),
                        ),
                      ],
                    )
            ],
          ))
        ],
      ),
    );
  }

  Future<dynamic> rateOrder(BuildContext context, orderId) {
    double stars = 3;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => sl<RateCubit>(),
          child: BlocBuilder<RateCubit, RateState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    width: double.infinity,
                    // height: heightScreen(context) / 1.5,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // sizedHeight(15),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  pop(context);
                                },
                                icon: Icon(Icons.close, color: Colors.black))
                          ],
                        ),
                        Text(
                          Strings.letRate.tr(),
                          style: TextStyles.textStyleFontBold20Black,
                        ),
                        verticalSpace(10.h),
                        SizedBox(
                          child: RatingBar.builder(
                            initialRating: stars,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                EdgeInsets.symmetric(horizontal: 4.0.w),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Palette.mainColor,
                            ),
                            onRatingUpdate: (rating) {
                              stars = rating;
                            },
                          ),
                        ),
                        sizedHeight(10.h),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black38, width: .8)),
                          child: TextField(
                            controller: _controllerComment,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                                hintText: Strings.letCooment.tr(),
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        state.addRateState == RequestState.loading
                            ? CustomCircularProgress(
                                size: Size(30.w, 30.h),
                                strokeWidth: 4,
                              )
                            : CustomButton(
                                onPressed: () {
                                  print(stars);
                                  RateCubit.get(context)
                                      .addRate(AddRateBodyModel(
                                    typeId: orderId,
                                    userId: currentUser!.user.id,
                                    comment: _controllerComment.text,
                                    type: ApiConstants.orderRate,
                                    stare: stars.toInt(),
                                  ))
                                      .then((value) {
                                    context.navigatePop();
                                    _controllerComment.clear();
                                  });
                                },
                                title: Strings.send.tr(),
                              ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
