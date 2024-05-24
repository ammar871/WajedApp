
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../../common/product/bloc/product_cubit/product_cubit.dart';
import '../../../../../common/product/data/models/product_model.dart';
import '../../../../../common/product/ui/product_details_screen/product_details_screen.dart';
import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/common_widgets/text_list_empty.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/enums/loading_status.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/theming/styles.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return state.getProcdutesByCategoryIdState == RequestState.loading
              ? const Center(child: CircularProgressIndicator())
              : state.productsResponse!.items.isEmpty
                  ? Center(child: TextListEmpty(text: Strings.noProducts.tr()))
                  : ListView.builder(
                      itemCount: state.productsResponse!.items.length,
                      itemBuilder: (context, index) {
                        ProductModel productModel =
                            state.productsResponse!.items[index];
                        return GestureDetector(
                          onTap: () {
                            context.navigatePush(BlocProvider(
                              create: (context) => sl<ProductCubit>(),
                              child: ProductDetailsScreen(
                                  productId: productModel.id),
                            ));
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Palette.kGreyColor,
                                          width: .3))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.h),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 64.w,
                                      width: 64.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: ImageNetworkWidget(
                                          imageUrl: context.getImageProduct(
                                              productModel.imageUrl),
                                          height: 64.w,
                                          width: 64.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productModel.nameAr,
                                            maxLines: 2,
                                            style: TextStyles
                                                .textStyleFontBold16greyColor
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                          ),
                                          verticalSpace(7.h),
                                          Text(
                                            productModel.descAr,
                                            maxLines: 2,
                                            style: TextStyles
                                                .textStyleFontRegular12greyColor
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    height: 1.0),
                                          ),
                                          verticalSpace(10.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                context.toPrice(
                                                    productModel.price),
                                                maxLines: 2,
                                                style: TextStyles
                                                    .textStyleFontBold16OrangeColor,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ])),
                        );
                      });
        },
      ),
    );
  }
}
