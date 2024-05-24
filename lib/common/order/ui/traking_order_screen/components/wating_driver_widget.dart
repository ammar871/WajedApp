import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class WatingDriverWidget extends StatelessWidget {
  const WatingDriverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(187, 0, 0, 0)),
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/traking.svg"),
                    verticalSpace(20.h)
                    ,SizedBox(
                      width: 250.w,
                      child: Text(
                        "جاري البحث \nعن كابتن".tr(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.textStyleFontBold45White
                           ),
                    ),
                  ],
                )
              )
            ]),
      );
  }
}
