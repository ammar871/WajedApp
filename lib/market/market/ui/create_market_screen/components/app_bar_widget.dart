import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/layout/app_assets.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/strings.dart';

class AppBarWidget extends StatelessWidget {
  final bool isUpdate;
  const AppBarWidget({
    super.key,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.restaurantColor,
      titleSpacing: 0,
      toolbarHeight: 130.h,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppAssets.appLogoInArabic),
                verticalSpace(10.h),
                Text(
                  isUpdate?Strings.updateAccountMarket.tr() :Strings.createAccountMarket.tr(),
                  style: TextStyles.textStyleFontBold20White,
                ),
              ],
            ),
          ],
        ),
      ),
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          pop(context);
        },
      ),
    );
  }
}
