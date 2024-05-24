import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';
import 'package:wajed_app/common/product/ui/add_options_product_screen/add_options_product_screen.dart';
import 'package:wajed_app/common/product/ui/add_product_screen/add_product_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/enums/loading_status.dart';
import '../components/add_cart_and_quntity_widget.dart';
import '../components/field_note_cart_wedget.dart';
import '../components/options_product_widget.dart';
import 'components/imges_slider_product_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductCubit>(context).getProductDetails(
        productId: widget.productId, userId: currentUser!.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffFCF9F7),
          appBar: AppBar(
            title: Text(
             Strings.detailsProduct.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          bottomSheet: context.isCleint(AppModel.currentRole)
              ? AddCartAndQuntityWidget(
                  productId: widget.productId,
                )
              :context.isResturant(AppModel.currentRole)? state.getProductDetailsState == RequestState.loaded
                  ? EditProductWidget(
                      productModel: state.productDetailsResponse!.product):SizedBox()
                  : const SizedBox(),
          body: getBodyProductDetails(state),
        );
      },
    );
  }


  Widget getBodyProductDetails(ProductState state) {
    switch (state.getProductDetailsState) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.error:
        return const Center(child: Text("Error"));
      case RequestState.loaded:
        return SingleChildScrollView(
            child: Column(children: [
          /// * images Product

          ImgesSliderProductWidget(
              images:
                  state.productDetailsResponse!.product.imageUrl.split("#")),

          /// * details Product and Options
          Padding(
            padding: const EdgeInsets.all(22).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *  price
                Row(
                  children: [
                    Text(
                        context.toPrice(
                            state.productDetailsResponse!.product.price),
                        style: TextStyles.textStyleFontBold12kDarkGrey),
                  ],
                ),
                verticalSpace(10.h),

                /// * name and desc

                Row(
                  children: [
                    Text(isAraic()?state.productDetailsResponse!.product.nameAr:
                    state.productDetailsResponse!.product.descEng
                    ,
                        style: TextStyles.textStyleFontBold20Black),
                  ],
                ),

                verticalSpace(10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(isAraic()?state.productDetailsResponse!.product.descAr:
                      state.productDetailsResponse!.product.descEng,
                      
                          maxLines: null,
                          style: TextStyles.textStyleFontRegular12greyColor),
                    ),
                  ],
                ),

                verticalSpace(20.h),
                OptionsProductWidget(
                  options: state.productDetailsResponse!.options,
                ),
                // verticalSpace(10.h),
                /// * add options for product details
                context.isResturant(AppModel.currentRole)
                    ? CustomButtonWithIcon(
                        title: Strings.addOptions.tr(),
                        backgroundColor: Palette.restaurantColor,
                        onPressed: () {
                          context.navigatePush(BlocProvider(
                            create: (context) => sl<ProductCubit>(),
                            child: AddOptionsProductScreen(
                              productId: widget.productId,
                            ),
                          ));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ))
                    : const SizedBox(),

                //* nots
                context.isResturant(AppModel.currentRole)
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Text(Strings.addNotes.tr(),
                                  style: TextStyles.textStyleFontBold20Black),
                            ],
                          ),
                          FieldNoteCartWedget(
                              controller: ProductCubit.get(context).controller),
                        ],
                      ),

                verticalSpace(100.h),
              ],
            ),
          )
        ]));

      case RequestState.pagination:
        return const Center(child: Text("Error"));
    }
  }
}

class EditProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const EditProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).w,
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
            backgroundColor: Palette.restaurantColor,
            onPressed: () {
              context.navigatePush(BlocProvider(
                create: (context) => sl<ProductCubit>(),
                child: AddProductScreen(
                    marketId: productModel.marketId,
                    productModel: productModel,
                    isUpdate: true),
              ));
            },
            title: "تعديل".tr(),
          )),
          horizontalSpace(10.w),
          Expanded(
              child: CustomButton(
            backgroundColor: Colors.red,
            onPressed: () {
              deleteDataDialog(
                  title: "حذف المنتج".tr(),
                  value: productModel.nameAr,
                  onDelete: () {
                    ProductCubit.get(context)
                        .deleteProduct(productModel.id, context: context);
                    pop(context);
                  },
                  context: context);
            },
            title: "حذف".tr(),
          )),
        ],
      ),
    );
  }
}
