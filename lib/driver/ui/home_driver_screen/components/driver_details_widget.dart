import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';

import '../../../../core/common_widgets/image_network.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/container_styles.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';
import '../../../data/models/driver_model.dart';

class DriverDetailsWidget extends StatelessWidget {
  final DriverModel driverModel;
  const DriverDetailsWidget({
    super.key,
    required this.driverModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            height: 70.w,
            width: 70.w,
            decoration: ContainerStyles.durationImage,
            child: ImageNetworkWidget(imageUrl: driverModel.profilleImage),
          ),
        ),
        horizontalSpace(20.w),
        // * name mraket
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
                child: Text(
                  Strings.welcome.tr(),
                  style: TextStyles.textStyleFontLight20ColorResturant,
                ),
              ),
              SizedBox(
                child: Text(
                  currentUser!.user.fullName,
                  maxLines: 2,
                  style: TextStyles.textStyleFontBold30ColorResturant,
                ),
              )
            ],
          ),
        )

        // * rate market
        ,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.status.tr(),
              style: TextStyles.textStyleFontReqluar12kDarkGrey,
            ),
            GFToggle(
              onChanged: (val) {
                // ProviderCubit.get(context)
                //     .onlineProvider(val!, context: context);
              },
              enabledText: "",
              disabledText: "",
              enabledTextStyle: const TextStyle(color: Colors.white),
              value: driverModel.status == 0 ? true : false,
              enabledTrackColor: Palette.restaurantColor.withOpacity(.3),
              enabledThumbColor: Palette.restaurantColor,
              type:
                  Platform.isAndroid ? GFToggleType.android : GFToggleType.ios,
            ),
          ],
        )
      ],
    );
  }
}
