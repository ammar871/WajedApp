import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/router/routes.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import 'package:wajed_app/market/home/ui/store_scrreen/components/products_widget.dart';
import 'package:wajed_app/user/cart/ui/components/divider_widget.dart';
import '../../../../common/product/ui/add_product_screen/add_product_screen.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_model.dart';
import '../../../market/ui/market_details_screen/market_details_screen.dart';

class StroeScreen extends StatelessWidget {
  const StroeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>(),
      child: BlocConsumer<HomeMarketCubit, HomeMarketState>(
        listener: (context, state) {
          if (state.getHomeMarketState == RequestState.loaded) {
            if (state.homeResponseMarket!.data!.categories.isNotEmpty) {
              ProductCubit.get(context).getProductsByCategoryId(
                  categoryId: 0, userId: currentUser!.user.id, page: 1,marketId: marketDetails!.id);
            }
          }
        },
        builder: (context, state) {
          return DefaultTabController(
            length: state.homeResponseMarket!.data!.categories.length + 1,
            child: Scaffold(

                /// * add data
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Palette.restaurantColor,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.w,
                  ),
                  onPressed: () {
                    //* show bottom sheet to add data
                    showBottomSheetWidget(
                        context,
                        addDataBottomSheet(context,
                            marketId: state.homeResponseMarket!.data!.market.id,
                            categories:
                                state.homeResponseMarket!.data!.categories));
                  },
                ),
                body: state.homeResponseMarket!.data!.categories.isEmpty
                    ? TextListEmpty(text: Strings.noProducts.tr())
                    : Column(
                        children: [
                          CategoriesProductsWidget(
                            backgroundColor: Palette.restaurantColor,
                            categories:
                                state.homeResponseMarket!.data!.categories,
                                marketId: marketDetails!.id,
                          ),

                          /// * products
                          verticalSpace(20.h),
                          const ProductsWidget()
                        ],
                      )),
          );
        },
      ),
    );
  }

  Widget addDataBottomSheet(BuildContext context, {marketId, categories}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(30).w,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        /// * close bootom
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 30.w,
                ))
          ],
        ),
        MaterialButton(
            minWidth: double.infinity,
            height: 60.h,
            onPressed: () {
              pop(context);
              context.navigateToNamed(Routes.categories);
            },
            child: Row(
              children: [
                Text(
                  Strings.categories.tr(),
                  style: TextStyles.textStyleFontBold20Black,
                ),
              ],
            )),
        const DividerWidget(hieght: 1, color: Colors.grey),
        MaterialButton(
            minWidth: double.infinity,
            height: 60.h,
            onPressed: () {
              pop(context);
              context.navigatePush(BlocProvider(
                create: (context) => sl<ProductCubit>(),
                child: AddProductScreen(marketId: marketDetails!.id),
              ));
            },
            child: Row(
              children: [
                Text(
                  Strings.addProduct.tr(),
                  style: TextStyles.textStyleFontBold20Black,
                ),
              ],
            )),
        verticalSpace(30.h)
      ]),
    );
  }
}
