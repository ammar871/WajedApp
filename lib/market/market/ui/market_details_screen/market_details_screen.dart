import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';

import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/services/services_locator.dart';
import '../../bloc/market_cubit/market_cubit.dart';
import '../components/market_details_card.dart';
import '../components/products_widget.dart';

class MarketDetailsScreen extends StatefulWidget {
  final int marketId;
  const MarketDetailsScreen({super.key, required this.marketId});

  @override
  State<MarketDetailsScreen> createState() => _MarketDetailsScreenState();
}

class _MarketDetailsScreenState extends State<MarketDetailsScreen> {
  List<ProductModel> productsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        title: Text(
          Strings.detailsMarket.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<MarketCubit>()
              ..emitGetMarketDetails(marketId: widget.marketId),
          ),
          BlocProvider(create: (context) => sl<ProductCubit>())
        ],
        child: BlocConsumer<MarketCubit, MarketState>(
          listener: (BuildContext context, MarketState state) async {
            if (state.getMarketDetailsState == RequestState.loaded) {
              if (state.marketDetailsResponse != null &&
                  state.marketDetailsResponse!.categories.isNotEmpty) {
                ProductCubit.get(context).getProductsByCategoryId(
                    categoryId: 0, userId: currentUser!.user.id, page: 1,marketId: widget.marketId);
              }
            }
          },
          builder: (context, state) {
            switch (state.getMarketDetailsState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                return DefaultTabController(
                  length: state.marketDetailsResponse!.categories.length + 1,
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, stateProduct) {
                      return CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 270.h,
                            automaticallyImplyLeading: false,
                            floating: false,
                            pinned: true,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: EdgeInsets.only(bottom: 20.h),
                              background: Container(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: DetailsMarketCard(
                                    market:
                                        state.marketDetailsResponse!.market),
                              ),
                            ),

                            //* categories
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(0.h),
                              child: CategoriesProductsWidget(
                                categories:
                                    state.marketDetailsResponse!.categories,
                                    marketId: widget.marketId,
                              ),
                            ),
                          ),

                          // *  products
                          if (stateProduct.productsResponse != null)
                            stateProduct.productsResponse!.items.isEmpty
                                ? SliverToBoxAdapter(
                                    child: SizedBox(
                                    height: context.height / 2,
                                    child: Center(
                                      child: TextListEmpty(
                                          text: Strings.noProducts.tr()),
                                    ),
                                  ))
                                : ProductsWidget(
                                    products:
                                        stateProduct.productsResponse!.items)
                        ],
                      );
                    },
                  ),
                );
              case RequestState.error:
                return Center(
                    child: Text(
                  Strings.someError.tr(),
                  style: const TextStyle(color: Colors.red),
                ));
              case RequestState.pagination:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class CategoriesProductsWidget extends StatelessWidget {
  final int marketId;
  final Color? backgroundColor;
  final List<CategoryModel> categories;
  const CategoriesProductsWidget(
      {super.key, required this.categories, this.backgroundColor, required this.marketId});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        width: context.width,
        
        decoration: const BoxDecoration(color: Palette.kTabBarColor),
        child: TabBar(
          
          labelColor: Palette.kTabBarColor,
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Palette.fontGreyColor,
          labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.symmetric(vertical: 5.h),
          onTap: (value) {
            if (value == 0) {
              ProductCubit.get(context).getProductsByCategoryId(
                categoryId: 0,
                userId: currentUser!.user.id,
                marketId: marketId,
                page: 1,
              );
            } else {
              print("filter");
              ProductCubit.get(context).getProductsByCategoryId(
                  categoryId: categories[value - 1].id,
                  userId: currentUser!.user.id,
                  marketId: marketId,
                  page: 1);
            }
          },
          
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(9.r),
              color: backgroundColor ?? Palette.mainColor),
          tabs: List.generate(categories.length + 1, (index) {
            if (index == 0) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Tab(
                  height:
                      context.isResturant(currentUser!.user.role) ? 80.h : 50.h,
                  text: Strings.all.tr(),
                ),
              );
            }
            final categoryModel = categories[index - 1];
            return Padding(
               padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Tab(
                height: context.isResturant(currentUser!.user.role) ? 80.h : 50.h,
                text: isAraic() ? categoryModel.nameAr : categoryModel.nameEng,
              ),
            );
          }),
        ));
  }
}


                 












                    // //* details Card
                    //     DetailsMarketCard(
                    //         market: state.marketDetailsResponse!.market),

                    //     // * tab categories
                    //     Container(
                    //         height: 60.h,
                    //         width: context.width,
                    //         decoration: const BoxDecoration(
                    //             color: Palette.kTabBarColor),
                    //         child: TabBar(
                    //           labelColor: Palette.kTabBarColor,
                    //           indicatorColor: Colors.transparent,
                    //           unselectedLabelColor: Palette.fontGreyColor,
                    //           isScrollable: true,
                    //           onTap: (value) {
                    //              ProductCubit.get(context).getProductsByCategoryId(
                    //                 categoryId: state.marketDetailsResponse!
                    //                     .categories[value].id,
                    //                 userId: currentUser!.user.id,
                    //                 page: 1);
                    //             setState(() {});
                    //           },
                    //           padding: EdgeInsets.symmetric(
                    //               vertical: 10.h, horizontal: 5.w),
                    //           indicator: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(9.r),
                    //               color: Palette.mainColor),
                    //           tabs: List.generate(
                    //               state.marketDetailsResponse!.categories
                    //                   .length, (index) {
                    //             CategoryModel categoryModel = state
                    //                 .marketDetailsResponse!.categories[index];
                    //             return Tab(
                    //               height: 50.h,
                    //               text: categoryModel.nameAr,
                    //             );
                    //           }),
                    //         )),
                    //     verticalSpace(20.h),
                    //     // *  products
                    //     BlocBuilder<ProductCubit, ProductState>(
                    //       builder: (context, state) {
                    //         return Expanded(
                    //             child: state.getProcdutesByCategoryIdState ==
                    //                     RequestState.loading
                    //                 ? Center(
                    //                     child: CustomCircularProgress(),
                    //                   )
                    //                 :ListView.builder(
                    //                   itemCount: state.productsResponse!.items.length,
                    //                   itemBuilder: (context, index) {
                    //                     return Container(
                    //                       height: 100,
                    //                       width: double.infinity,
                    //                       color: Colors.red,margin: EdgeInsets.all(10),
                    //                     );
                    //                 }));
                    //       },
                    //     )
                   