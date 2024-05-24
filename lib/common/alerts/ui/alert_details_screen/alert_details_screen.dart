import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/alerts/data/models/alert_model.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';

class AlertDetailsScreen extends StatelessWidget {
  final AlertModel alertModel;
  const AlertDetailsScreen({super.key,required this.alertModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.alertDetail.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0).w,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                 Text(
                  isAraic()()
                      ? alertModel.titleAr
                      :alertModel.titleEng,
                  textAlign: TextAlign.center,
                  style:TextStyles.textStyleFontReqular26kBlack,
                ),
                verticalSpace(20.h),
                Text(
                  isAraic()()
                      ? alertModel.descAr
                      :alertModel.descEng,
                  textAlign: TextAlign.center,
                  style:TextStyles.textStyleFontRegular16greyColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
