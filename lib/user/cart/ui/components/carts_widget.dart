import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../common/product/ui/components/quntity_widget.dart';
import '../../../../core/theming/styles.dart';
import '../../bloc/cart_cubit/cart_cubit.dart';
import '../../data/models/cart_model.dart';

class CartsWidget extends StatelessWidget {
  final List<CartDeatails> carts;
  const CartsWidget({
    super.key,
    required this.carts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: carts.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          CartDeatails cartDeatails = carts[index];
          return Container(
            margin: EdgeInsets.only(bottom: 14.h),
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    minWidth: 40.w,
                    height: 40.h,
                    onPressed: () {
                      deleteDataDialog(
                        context: context,
                          value: cartDeatails.product.nameAr,
                          title: Strings.sureDelete.tr(),
                          onDelete: () {
                            pop(context);
                            CartCubit.get(context).deleteCart(cartDeatails.cart.id);
                          });
                      // CartCubit.get(context).deleteCart(cartDeatails.cart.id);
                    },
                    child: SvgPicture.asset("assets/images/delete_ico.svg"),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                  child: Column(children: [
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                             isAraic()? cartDeatails.product.nameAr: cartDeatails.product.nameEng,
                              style: TextStyles.textStyleFontBold16BlackAppBar
                                  .copyWith(
                                      height: .5,
                                      overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: cartDeatails.options
                              .map((e) => Text(
                                   isAraic()? e.nameAr: e.nameEng,
                                    style: TextStyles
                                        .textStyleFontRegular14greyColor
                                        .copyWith(height: 1.2),
                                  ))
                              .toList(),
                        ),
                        QuntityWidget(
                          quntity: CartCubit.get(context)
                              .quantitiesMap[cartDeatails.product.id]!,
                          onAdd: () {
                            CartCubit.get(context).add(
                                index,
                                cartDeatails.cart.cost,
                                cartDeatails.cart.id,
                                cartDeatails.product.id);
                          },
                          inMinus: () {
                            CartCubit.get(context).mins(
                                index,
                                cartDeatails.cart.cost,
                                cartDeatails.cart.id,
                                cartDeatails.product.id);
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          context.toPrice2(cartDeatails.cart.cost),
                          style: TextStyles.textStyleFontRegular14greyColor
                              .copyWith(height: .5),
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            ),
          );
        });
  }
}
