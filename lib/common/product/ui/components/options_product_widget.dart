import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';

import '../../../../core/constants/layout/palette.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/theming/styles.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../data/models/option_model.dart';
import '../../data/models/options_response.dart';

class OptionsProductWidget extends StatefulWidget {
  final List<OptionsResponse> options;
  const OptionsProductWidget({super.key, required this.options});

  @override
  State<OptionsProductWidget> createState() => _OptionsProductWidgetState();
}

class _OptionsProductWidgetState extends State<OptionsProductWidget> {
  @override
  Widget build(BuildContext context) {
    return

        /// * options
        SizedBox(
      width: context.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.options.length,
          itemBuilder: (context, indexGroup) {
            OptionsResponse optionsResponse = widget.options[indexGroup];
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        isAraic()?optionsResponse.group.nameAr:
                        optionsResponse.group.nameEng,
                        style: TextStyles.textStyleFontBold20Black,
                      ),
                    ],
                  ),
                  verticalSpace(10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        optionsResponse.productsOptions1.length, (index) {
                      OptionModel e = optionsResponse.productsOptions1[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (ProductCubit.get(context)
                                          .idsOptipns[indexGroup] ==
                                      e.id) {
                                    ProductCubit.get(context)
                                        .idsOptipns[indexGroup] = 0;
                                  } else {
                                    ProductCubit.get(context)
                                        .idsOptipns[indexGroup] = e.id;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 20.w,
                                  width: 20.w,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ProductCubit.get(context)
                                                  .idsOptipns[indexGroup] ==
                                              e.id
                                          ? Colors.white
                                          : Palette.fontGreyColor,
                                      border: Border.all(
                                          width: 5.w,
                                          color: ProductCubit.get(context)
                                                      .idsOptipns[indexGroup] ==
                                                  e.id
                                              ? Palette.mainColor
                                              : Colors.transparent)),
                                ),
                              ),
                              horizontalSpace(10.w),
                              Text(
                                e.nameAr,
                                style:
                                    TextStyles.textStyleFontReqular20kDarkGrey,
                              )
                            ],
                          ),
                          Text(
                            context.toPrice2(e.price),
                            style: TextStyles.textStyleFontReqular20kDarkGrey,
                          )
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            );
          }),
    );
  }
}
