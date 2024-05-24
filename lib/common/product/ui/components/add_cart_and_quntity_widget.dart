import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/common_widgets/circular_progress.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/cart/bloc/cart_cubit/cart_cubit.dart';
import 'package:wajed_app/user/cart/data/models/add_cart_body_request.dart';
import 'package:wajed_app/user/cart/ui/cart_screen/cart_screen.dart';

import '../../../../core/enums/loading_status.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import 'quntity_widget.dart';

class AddCartAndQuntityWidget extends StatelessWidget {
  final int productId;

  const AddCartAndQuntityWidget({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Container(
              height: 100.h,
              margin: EdgeInsets.only(bottom: 20.h),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.addCartState == RequestState.loading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomCircularProgress(),
                          ],
                        )
                      : TextButton(
                          onPressed: () {
                            // todo : add cart ========================================

                            CartCubit.get(context).addCart(AddCartBodyRequest(
                                quantity: CartCubit.get(context).quntity,
                                cost: 0,
                                userId: currentUser!.user.id,
                                nots: ProductCubit.get(context)
                                        .controller
                                        .text
                                        .isEmpty
                                    ? ""
                                    : ProductCubit.get(context).controller.text,
                                productId: productId,
                                optionsIds: getOptionsSelctor(
                                    ProductCubit.get(context).idsOptipns)));
                          },
                          child: Text(
                            Strings.addCart.tr(),
                            style: TextStyles.textStyleFontBold20OrangeColor,
                          ),
                        ),

                  // ** go cart
                  MaterialButton(
                    onPressed: () {
                      // todo : go to cart

                      context.navigatePush(BlocProvider(
                        create: (context) => sl<CartCubit>(),
                        child: const CartScreen(),
                      ));
                    },
                    child: SvgPicture.asset("assets/images/home/cart.svg"),
                  ),

                  //* Quntity
                  QuntityWidget(
                    quntity: CartCubit.get(context).quntity,
                    onAdd: () {
                      CartCubit.get(context).addQuntity(isAdd: true);
                    },
                    inMinus: () {
                      CartCubit.get(context).addQuntity(isAdd: false);
                    },
                  )
                ],
              ));
        },
      ),
    );
  }

  String getOptionsSelctor(List<int> idsOptipns) {
    
    List<int> options = [];
    for (var id in idsOptipns) {
      if (id != 0) {
        options.add(id);
      }
    }
    return options.join("#");
  }
}
