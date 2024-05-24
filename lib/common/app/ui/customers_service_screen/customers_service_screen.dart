import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/theming/styles.dart';

class CustomersServiceScreen extends StatelessWidget {
  const CustomersServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
         Strings.coustmersService.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30).w,
        child: Column(children: [
          //
          CustomButtonWithChild(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.quiezes.tr()),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 15.w,
                )
              ],
            ),
            onPressed: () {},
          ),
          verticalSpace(30.h),
          CustomButtonWithChild(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.about.tr()),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 15.w,
                )
              ],
            ),
            onPressed: () {},
          ) ,verticalSpace(30.h),
          CustomButtonWithChild(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.callUs.tr()),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 15.w,
                )
              ],
            ),
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
