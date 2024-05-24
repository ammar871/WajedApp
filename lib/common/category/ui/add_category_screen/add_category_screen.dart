import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/category/bloc/cubit/category_cubit.dart';
import 'package:wajed_app/common/category/data/models/add_category_body_request.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/category/data/models/update_category_body.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/theming/styles.dart';
import '../../../../market/market/ui/create_market_screen/components/text_form_create_market_widget.dart';
import '../../../../market/market/ui/create_market_screen/components/title_field_widget.dart';

class AddCategoryScreen extends StatefulWidget {
  final bool isUpdate;
  final CategoryModel? categoryModel;
  final int marketId;
  const AddCategoryScreen(
      {super.key,
      required this.marketId,
      this.isUpdate = false,
      this.categoryModel});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _titleArController.text = widget.categoryModel!.nameAr;
      _titleEnController.text = widget.categoryModel!.nameEng;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleArController.dispose();
    _titleEnController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Text(
            Strings.addCategory.tr(),
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(30).w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// * name Market
                    verticalSpace(30.h),
                    TitleFieldWidget(
                      title: Strings.nameCategorAr.tr(),
                    ),
                    TextFormCreateMarketWidget(
                      controller: _titleArController,
                      hint: Strings.nameCategorAr.tr(),
                    ),

                    verticalSpace(30.h),
                    TitleFieldWidget(
                      title: Strings.nameCategorEng.tr(),
                    ),
                    TextFormCreateMarketWidget(
                      controller: _titleEnController,
                      hint: Strings.nameCategorEng.tr(),
                    ),
                    verticalSpace(50.h),

                    /// * button add
                    state.addCategoryState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: Strings.create.tr(),
                            backgroundColor: Palette.restaurantColor,
                            onPressed: () {
                              if (validate()) {
                                if (widget.isUpdate) {
                                  CategoryCubit.get(context).updateCategory(
                                  
                                      UpdateCategoryBody(
                                        nameAr: _titleArController.text,
                                        nameEng: _titleEnController.text,
                                        id: widget.categoryModel!.id,
                                      ),
                                      context);
                                } else {
                                  CategoryCubit.get(context).addCategory(
                                      AddCategoryBodyRequest(
                                        nameAr: _titleArController.text,
                                        nameEng: _titleEnController.text,
                                        marketId: widget.marketId,
                                      ),
                                      context);
                                }
                              }
                            }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool validate() {
    if (_titleArController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameAr.tr());
      return false;
    } else if (_titleEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.nameCategorEng.tr());

      return false;
    } else {
      return true;
    }
  }
}
