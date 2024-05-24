import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/ui/product_details_screen/product_details_screen.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../common/product/data/models/product_model.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/image_network.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class ProductsWidget extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        ProductModel productModel = products[index];
        return GestureDetector(
          onTap: () {
            context.navigatePush(BlocProvider(
              create: (context) => sl<ProductCubit>(),
              child: ProductDetailsScreen(productId: productModel.id),
            ));
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: ImageNetworkWidget(
                      imageUrl: context.getImageProduct(productModel.imageUrl),
                      height: 64.w,
                      width: 64.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                horizontalSpace(10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       isAraic()? productModel.nameAr: productModel.nameEng,
                        maxLines: 2,
                        style: TextStyles.textStyleFontBold16greyColor
                            .copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      verticalSpace(7.h),
                      Text(
                       isAraic()? productModel.descAr:productModel.descEng,
                        maxLines: 2,
                        style: TextStyles.textStyleFontRegular12greyColor
                            .copyWith(
                                overflow: TextOverflow.ellipsis, height: 1.0),
                      ),
                      verticalSpace(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.toPrice(productModel.price),
                            maxLines: 2,
                            style: TextStyles.textStyleFontBold16OrangeColor,
                          ),
                          SizedBox(
                            width: 90.w,
                            height: 35.h,
                            child: CustomButtonWithIcon(
                                title:Strings.add.tr(),
                                titleColor: Colors.white,
                                onPressed: () {
                                  context.navigatePush(BlocProvider(
                                    create: (context) => sl<ProductCubit>(),
                                    child: ProductDetailsScreen(
                                        productId: productModel.id),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 2,
      ),
    );
  }
}
