import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/profile/ui/profile_screen/profile_screen.dart';
import 'package:wajed_app/core/common_widgets/image_network.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';

class UserDataDrawer extends StatelessWidget {
  const UserDataDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.isCleint(currentUser!.user.role)) {
          context.navigatePush(ProfileScreen());
        }
      },
      child: Row(
        children: [
          // * image profiel
          Container(
            height: 50.w,
            width: 50.w,
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x59000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
                border: Border.all(color: Colors.white, width: 2)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: ImageNetworkWidget(
                imageUrl: currentUser!.user.profileImage??"",
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
                errorWidget: Image.asset(
                  "assets/images/error_image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          // name And Phone
          ,
          horizontalSpace(10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser!.user.fullName,
                style:
                    TextStyles.textStyleFontBold27White.copyWith(height: 1.0),
              ),
              Text(
                currentUser!.user.userName,
                style:
                    TextStyles.textStyleFontLight14White.copyWith(height: 1.0),
              )
            ],
          )
        ],
      ),
    );
  }
}
