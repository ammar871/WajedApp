import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/theming/styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Text(
             Strings.settings.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            horizontalSpace(10.w),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: Palette.kOrangeColor,size: 20.w,))
          ],
        ),
      ),
    );
  }
}
