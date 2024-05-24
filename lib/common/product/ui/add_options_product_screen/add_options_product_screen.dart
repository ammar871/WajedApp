import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/data/models/add_options_controllers.dart';
import 'package:wajed_app/common/product/data/models/group_options_model.dart';
import 'package:wajed_app/common/product/data/models/option_model.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../market/market/ui/create_market_screen/components/text_form_create_market_widget.dart';
import '../../../../market/market/ui/create_market_screen/components/title_field_widget.dart';
import '../../data/models/add_options_body.dart';

class AddOptionsProductScreen extends StatefulWidget {
  final int productId;

  const AddOptionsProductScreen(
      {super.key,
      required this.productId,
});

  @override
  State<AddOptionsProductScreen> createState() =>
      _AddOptionsProductScreenState();
}

class _AddOptionsProductScreenState extends State<AddOptionsProductScreen> {
  final _titleArController = TextEditingController();

  final _titleEnController = TextEditingController();
  List<OptionModel> options = [];

  final List<AddOptionsController> _controllersOptions = [];





  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    for (var element in _controllersOptions) {
      element.nameAr.dispose();
      element.nameEng.dispose();
      element.price.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         Strings.addOptions.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(30).w,
            child: SingleChildScrollView(
              child: Form(
                child: Column(children: [
                  /// * name Market
                  TitleFieldWidget(
                    title: Strings.nameGroupAr.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleArController,
                    hint: Strings.descNameGroupAr.tr(),
                  ),
                  verticalSpace(30.h),
                  TitleFieldWidget(
                    title: Strings.nameGroupEng.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleEnController,
                    hint: Strings.descNameGroupEng.tr(),
                  ),
                  verticalSpace(30.h),
                  // * add options
                  Row(
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: CustomButton(
                            backgroundColor: Palette.restaurantColor,
                            title: Strings.addOption.tr(),
                            onPressed: () {
                              _controllersOptions.add(AddOptionsController(
                                nameAr: TextEditingController(),
                                nameEng: TextEditingController(),
                                price: TextEditingController(),
                              ));
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  verticalSpace(30.0.w),
                  Column(
                    children: _controllersOptions
                        .map((e) => Row(
                              children: [
                                Expanded(
                                  child: TextFormCreateMarketWidget(
                                    controller: e.nameAr,
                                    hint: Strings.nameAr.tr(),
                                  ),
                                ),
                                horizontalSpace(4.w),
                                Expanded(
                                  child: TextFormCreateMarketWidget(
                                    controller: e.nameEng,
                                    hint:Strings.nameEng.tr(),
                                  ),
                                ),
                                horizontalSpace(4.w),
                                Expanded(
                                  child: TextFormCreateMarketWidget(
                                    controller: e.price,
                                    hint: Strings.pric.tr(),
                                  ),
                                ),
                                horizontalSpace(4.w),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      if (_controllersOptions.isNotEmpty) {
                                        _controllersOptions.remove(e);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 20.w,
                                    ))
                              ],
                            ))
                        .toList(),
                  ),

                  verticalSpace(30.h),
                  state.addOptionsState == RequestState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: Strings.create.tr(),
                          backgroundColor: Palette.restaurantColor,
                          onPressed: () {
                            if (validate()) {
                              GroupOptionsModel groupOptionsModel =
                                  GroupOptionsModel(
                                id: 0,
                                nameAr: _titleArController.text,
                                nameEng: _titleEnController.text,
                                productId: widget.productId,
                              );

                              /// * add options
                              for (var element in _controllersOptions) {
                                options.add(OptionModel(
                                    nameAr: element.nameAr.text,
                                    nameEng: element.nameEng.text,
                                    price: double.parse(element.price.text),
                                    productId: widget.productId,
                                    groupId: 0,
                                    id: 0));
                              }

                              AddOptionsBody optionsResponse = AddOptionsBody(
                                  groupOptions: groupOptionsModel,
                                  options: options);

                              ProductCubit.get(context)
                                  .addOptionsProduct(context, optionsResponse);
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

  bool validate() {
    if (_titleArController.text.isEmpty) {
      showToast(color: Colors.red, msg:Strings.inputNameGroupAr.tr());
      return false;
    } else if (_titleEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameGroupEng.tr());

      return false;
    } else if (_controllersOptions.isEmpty) {
      showToast(color: Colors.red, msg: Strings.addOption.tr());

      return false;
    } else if (_controllersOptions.every((element) =>
        element.nameAr.text.isEmpty ||
        element.nameEng.text.isEmpty ||
        element.price.text.isEmpty)) {
      showToast(color: Colors.red, msg:  Strings.inputallOptions.tr());

      return false;
    } else {
      return true;
    }
  }
}
