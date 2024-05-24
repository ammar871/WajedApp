import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/data/models/add_product_body.dart';
import 'package:wajed_app/core/common_widgets/image_network.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/drop_dwon_widget.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/spacing.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';
import '../../../../market/market/ui/create_market_screen/components/text_form_create_market_widget.dart';
import '../../../../market/market/ui/create_market_screen/components/title_field_widget.dart';
import '../../data/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  final int marketId;
  final ProductModel? productModel;
  final bool isUpdate;

  const AddProductScreen(
      {super.key,
      required this.marketId,
      this.productModel,
      this.isUpdate = false});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descArController = TextEditingController();
  final _descEnController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
   
    super.initState();
    if (widget.isUpdate) {
      ProductCubit.get(context)
          .getImagesForUpdaetProduct(widget.productModel!.imageUrl);
      categoryModel = categories.firstWhere(
          (element) => element.id == widget.productModel!.categoryId);
      _titleArController.text = widget.productModel!.nameAr;
      _titleEnController.text = widget.productModel!.nameEng;
      _descArController.text = widget.productModel!.descAr;
      _descEnController.text = widget.productModel!.descEng;
      _priceController.text = widget.productModel!.price.toString();
    }
  }

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _descArController.dispose();
    _descEnController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.addProduct.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
       
        },
        builder: (context, state) {
          
          return Padding(
            padding: const EdgeInsets.all(30).w,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  /// *select field
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Palette.restaurantColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomDropDownWidget(
                      currentValue: categoryModel,
                      list: categories
                          .map((e) => DropdownMenuItem<CategoryModel>(
                              value: e,
                              child: Text(
                                e.nameAr,
                                style:
                                    TextStyles.textStyleFontBold16OrangeColor,
                              )))
                          .toList(),
                      onSelect: (val) {
                        categoryModel = val;
                        setState(() {});
                      },
                      hint: Strings.addCategoryToProduct.tr(),
                    ),
                  ),

                  /// * name Market
                  TitleFieldWidget(
                    title: Strings.nameProductAr.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleArController,
                    hint:  Strings.nameProductAr.tr(),
                  ),
                  verticalSpace(30.h),
                  TitleFieldWidget(
                    title:Strings.nameProductEng.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleEnController,
                    hint:Strings.nameProductEng.tr(),
                  ),
                  verticalSpace(30.h),

                  /// * description market
                  TitleFieldWidget(
                    title:Strings.descProductAr.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _descArController,
                    hint:Strings.descProductAr.tr(),
                  ),
                  verticalSpace(30.h),
                  TitleFieldWidget(
                    title: Strings.descProductEng.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _descEnController,
                    hint: Strings.descProductEng.tr(),
                  ),
                  verticalSpace(30.h),

                  /// * price market
                  TitleFieldWidget(
                    title: Strings.pricProduct.tr().tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _priceController,
                    hint: Strings.pricProduct.tr(),
                  ),
                  verticalSpace(30.h),

                  /// * Required personal documents
                  TitleFieldWidget(
                    title: Strings.photoProduct.tr(),
                  ),
                  verticalSpace(20.h),

                  /// * upload images
                  SizedBox(
                    height: 140.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            1 + ProductCubit.get(context).images.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ProductCubit.get(context).images.length ==
                                    5
                                ? const SizedBox()
                                : GestureDetector(
                                    onTap: () async {
                                      await ProductCubit.get(context)
                                          .uploadImage();
                                    },
                                    child: Container(
                                      height: 130.h,
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Palette.restaurantColor),
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                        size: 60.w,
                                      ),
                                    ),
                                  );
                          } else {
                            String image =
                                ProductCubit.get(context).images[index - 1];
                            return AddImageWidget(
                                image: image,
                                onRemove: () {
                                  ProductCubit.get(context)
                                      .removeImage(index - 1);
                                });
                          }
                        }),
                  ),

                  verticalSpace(30.h),
                  state.addProductState == RequestState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: Strings.create.tr(),
                          backgroundColor: Palette.restaurantColor,
                          onPressed: () {
                            if (validate(
                                images: ProductCubit.get(context).images)) {
                              if (widget.isUpdate) {
                                ProductCubit.get(context).updateProduct(
                                    ProductModel(
                                        id: widget.productModel!.id,
                                        categoryId: categoryModel!.id,
                                        nameAr: _titleArController.text,
                                        nameEng: _titleEnController.text,
                                        descAr: _descArController.text,
                                        descEng: _descEnController.text,
                                        marketId: widget.marketId,
                                        price: double.parse(
                                            _priceController.text),
                                        imageUrl: ProductCubit.get(context)
                                            .images
                                            .join("#"),
                                        status: widget.productModel!.status,
                                        isCart: false,
                                        fieldId: widget.productModel!.fieldId,
                                        createdAt:
                                            widget.productModel!.createdAt),
                                    context: context);
                              } else {
                                ProductCubit.get(context).addProduct(
                                    AddProductBody(
                                        categoryId: categoryModel!.id,
                                        nameAr: _titleArController.text,
                                        nameEng: _titleEnController.text,
                                        descAr: _descArController.text,
                                        descEng: _descEnController.text,
                                        marketId: widget.marketId,
                                        price: double.parse(
                                            _priceController.text),
                                        imageUrl: ProductCubit.get(context)
                                            .images
                                            .join("#")),
                                    context: context);
                              }
                            }
                          }),
                  verticalSpace(100.h),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validate({images}) {
    if (_titleArController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameAr.tr());
      return false;
    } else if (_titleEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameAr.tr());

      return false;
    } else if (_descArController.text.isEmpty) {
      showToast(color: Colors.red, msg:Strings.inputDescAr.tr());

      return false;
    } else if (_descEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputDescEng.tr());

      return false;
    } else if (_priceController.text.isEmpty) {
      showToast(color: Colors.red, msg:Strings.inputPric.tr());

      return false;
    } else if (images.isEmpty) {
      showToast(color: Colors.red, msg: Strings.selctPhotProduct.tr());

      return false;
    } else if (categoryModel == null) {
      showToast(color: Colors.red, msg:Strings.addCategoryToProduct.tr());

      return false;
    } else {
      return true;
    }
  }
}

class AddImageWidget extends StatelessWidget {
  final String image;
  final void Function() onRemove;
  const AddImageWidget({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      height: 130.h,
      width: 140.w,
      child: Stack(
        children: [
          // *  image
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: ImageNetworkWidget(
                  imageUrl: image,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )),

          // *  remove
          Positioned(
              top: 4.w,
              right: 4.w,
              child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(1).w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 15.w,
                    ),
                  )))
        ],
      ),
    );
  }
}
