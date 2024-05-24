import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/app_sizes.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/market/market/ui/markets_screen/markets_screen.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';

import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../market/market/bloc/market_cubit/market_cubit.dart';

class FieldsListWidget extends StatelessWidget {
  final List<FieldModel> fields;
  const FieldsListWidget({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 123.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: fields.length,
          itemBuilder: (context, index) {
            FieldModel field = fields[index];

            return FieldCard(
              title: isAraic()?field.nameAr:field.nameEng,
              fieldId: field.id,
              logo: CachedNetworkImage(
                imageUrl: ApiConstants.baseUrlImages + field.imageUrl,
                errorWidget: (context, url, error) {
                  return const SizedBox();
                },
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}

class FieldCard extends StatelessWidget {
  const FieldCard({
    Key? key,
    required this.logo,
    required this.title,
    required this.fieldId,
  }) : super(key: key);

  final Widget logo;
  final String title;
  final int fieldId;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(AppSize.s14.r));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s5, vertical: 15.h),
      child: Material(
        shadowColor: Palette.kBlackColor.withOpacity(0.5),
        borderRadius: borderRadius,
        color: Palette.white,
        elevation: AppSize.s7,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
              context.navigatePush(BlocProvider(
          create: (context) => sl<MarketCubit>(),
          child: MarketsScreen(fieldId: fieldId,title: title),
        ));
          },
          child: SizedBox(
            width: context.width * 0.27.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: AppSize.s40.w,
                  height: AppSize.s40.w,
                  child: logo,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s2),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleS.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.kDarkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
