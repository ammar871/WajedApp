import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/cart/bloc/cart_cubit/cart_cubit.dart';
import 'package:wajed_app/user/cart/data/models/payment_method_model.dart';
import 'package:wajed_app/user/cart/ui/review_order_screen/review_order_screen.dart';
import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/spacing.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../components/carts_widget.dart';
import '../components/container_payment_method_and_copoun.dart';
import '../components/divider_widget.dart';
import '../components/field_time_deleviary_widget.dart';
import '../components/row_order_pricies.dart';
import '../components/select_address_order_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  PaymentMethodModel currentPayMent =
      PaymentMethodModel(id: 1, name: 'cash'.tr());

  final _controller = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    CartCubit.get(context).getCarts(currentUser!.user.id, "");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (contextBloc, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.carts.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          bottomSheet:state.cartResponse==null||state.cartResponse!.carts.isEmpty?const SizedBox(): Container(
            margin: const EdgeInsets.all(30).w,
            child: CustomButton(
                title: Strings.addOrder.tr(),
                onPressed: () {
                  context.navigatePush(ReviewOrderScreen(
                      currentPayMent: currentPayMent,
                      address: currentDefulteAddress!,
                      time: _controller.text,
                      cartResponse: state.cartResponse!));
                }),
          ),
          body: getBody(state, contextBloc),
        );
      },
    );
  }

// * ============================ . getBody
  Widget getBody(CartState state, contextBloc) {
    switch (state.getCartsaState) {
      case RequestState.loaded:
        return state.cartResponse!.carts.isEmpty?
           TextListEmpty(text:Strings.noCarts.tr())
          
          : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10).w,
                child: Column(
                  children: [
                    // * ============= Select address
                    const SelectAddressOrderWidget(),

                    verticalSpace(25.h),

                    /// *   ============= List Carts
                    CartsWidget(carts: state.cartResponse!.carts)

                    /// * Prices and Payment Method
                    ,

                    const DividerWidget(
                      hieght: .5,
                      color: Color(0xff707070),
                    ),
                    verticalSpace(20.h),

                    /// * payment method
                    ContainerPaymentMethodAndCopoun(
                        icon: Icons.arrow_forward_ios_sharp,
                        onPress: () {
                          /// * show the payment method bottom sheet
                          paymentMethodSheet();
                        },
                        title:Strings.paymentMethod.tr(),
                        value: currentPayMent.name,
                        textColor: Palette.kDarkGrey),

                    verticalSpace(15.h),

                    /// * copun
                    ContainerPaymentMethodAndCopoun(
                        icon: Icons.delete,
                        onPress: () {},
                        title: Strings.copun.tr(),
                        value: "واجد44",
                        textColor: Palette.kOrangeColor),

                    verticalSpace(15.h),
                    RowOrderPricies(
                      title: Strings.priceOrder.tr(),
                      value: context.toPrice(state.cartResponse!.productsCost),
                    ),

                    RowOrderPricies(
                      title:Strings.delivaryCost.tr(),
                      value: context.toPrice(state.cartResponse!.tax),
                    ),
                    RowOrderPricies(
                      title:Strings.updatePric.tr(),
                      value: context.toPrice(state.cartResponse!.totalCost),
                    ),
                    verticalSpace(20.h),
                    Text(
                      Strings.taxToProducts.tr(),
                      style: TextStyles.textStyleFontReqular16kDarkGrey,
                    ),
                    verticalSpace(10.h),
                    const DividerWidget(hieght: .5, color: Palette.kDarkGrey),
                    verticalSpace(15.h),
                  ],
                ),
              ),

              /// * container total
              Container(
                height: 50.h,
                decoration: const BoxDecoration(
                    color: Palette.kStepperLineInactiveColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.total.tr(),
                      style: TextStyles.textStyleFontBold20Black,
                    ),
                    horizontalSpace(20.w),
                    Text(
                      context.toPrice(CartCubit.get(context).total),
                      style: TextStyles.textStyleFontBold20Black,
                    )
                  ],
                ),
              ),
              verticalSpace(15.h),

              /// * note  Order
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                     Strings.timeDelivary.tr(),
                      style: TextStyles.textStyleFontBold20kDarkGrey,
                    ),
                  ],
                ),
              ),
              verticalSpace(8.h),
              FieldTimeDeleviaryWidget(controller: _controller),

              verticalSpace(200.h)
            ],
          ),
        );

      case RequestState.error:
        return const Text("error");
      case RequestState.loading:
        return const CustomCircularProgress();
      default:
        return const Text("error");
    }
  }

  /// * show the payment method bottom sheet
  void paymentMethodSheet() {
    showBottomSheetWidget(
        context,
        Container(
          padding:
              EdgeInsets.only(top: 40.h, left: 30.w, right: 30.w, bottom: 20.h),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: context.height / 2.2,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "طرق الدفع ".tr(),
              style: TextStyles.textStyleFontBold20OrangeColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: payments.length,
                    itemBuilder: (ctx, index) {
                      PaymentMethodModel paymentMethodModel = payments[index];
                      return GestureDetector(
                        onTap: () {
                          pop(context);
                          currentPayMent = paymentMethodModel;
                          setState(() {});
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black45, width: .8))),
                          child: Row(
                            children: [
                              Text(
                                paymentMethodModel.name,
                                style: TextStyles.textStyleFontBold20Black,
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ));
  }
}
