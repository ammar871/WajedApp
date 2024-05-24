import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/theming/styles.dart';

class SettingsScreen extends StatelessWidget {
  final bool isNav;

  const SettingsScreen({super.key, this.isNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isNav
          ? null
          : AppBar(
              title: Text(
                Strings.settings.tr(),
                style: TextStyles.textStyleFontBold16BlackAppBar,
              ),
              automaticallyImplyLeading: true,
              elevation: 0,
            ),
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerSettingWidget(
                title: Strings.theName.tr(),
                value: currentUser!.user.fullName,
              ),
              ContainerSettingWidget(
                title: Strings.phone.tr(),
                value: currentUser!.user.userName,
              ),
              ContainerSettingWidget(
                title: Strings.email.tr(),
                value: currentUser!.user.email,
              ),
              ContainerSettingWidget(
                title: Strings.rate.tr(),
                value: "",
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.w,
                  color: Palette.kDarkGrey,
                ),
              ),
              ContainerSettingWidget(
                title: Strings.shareApp.tr(),
                value: "",
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.w,
                  color: Palette.kDarkGrey,
                ),
              ),

              /// * icons scail
              verticalSpace(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      size:30.w,
                      color: Palette.kBlackColor,
                    ),
                  ),
                  horizontalSpace(10.w),
                   IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      size:30.w,
                      color: Palette.kBlackColor,
                    ),
                  ),
                    horizontalSpace(10.w),
                   IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      size:30.w,
                      color: Palette.kBlackColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerSettingWidget extends StatelessWidget {
  final String title, value;
  final Widget? child;
  const ContainerSettingWidget({
    super.key,
    required this.title,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Palette.kGreyColor, width: 1))),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyles.textStyleFontBold16fontGreyColor,
          )),
          Expanded(
              child: child ??
                  Text(
                    value,
                    style: TextStyles.textStyleFontBold16BlackAppBar,
                  )),
        ],
      ),
    );
  }
}
