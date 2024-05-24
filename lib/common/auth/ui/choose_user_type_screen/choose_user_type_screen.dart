import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/auth/ui/choose_login_register_screen/choose_login_register_screen.dart';

import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/extension/app_extensions.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';
import 'package:wajed_app/core/helpers/session_manager.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/home/ui/home_screen/home_screen.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_radius.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/user_roles.dart';
import '../../../../core/helpers/helper_functions.dart';

class ChooseUserTypeScreen extends StatefulWidget {
  const ChooseUserTypeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseUserTypeScreen> createState() => _ChooseUserTypeScreenState();
}

class _ChooseUserTypeScreenState extends State<ChooseUserTypeScreen> {
  UserRoles userRole = UserRoles.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      Strings.selectTypeAccount.tr(),
                      style: context.headlineS.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: AppSize.s100),

                    // Choose user role/type
                    ChooseUserRoleButton(
                      title: Strings.client.tr(),
                      backgroundColor: Palette.kClientColor,
                      userRoles: UserRoles.client,
                      isSelected: userRole == UserRoles.client ? true : false,
                      onChanged: (val) {
                        log("Current user role1:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppSize.s14),
                    ChooseUserRoleButton(
                      title: Strings.market.tr(),
                      backgroundColor: Palette.kDealerColor,
                      userRoles: UserRoles.restaurant,
                      isSelected:
                          userRole == UserRoles.restaurant ? true : false,
                      onChanged: (val) {
                        log("Current user role3:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppSize.s14),
                    ChooseUserRoleButton(
                      title: Strings.delivary.tr(),
                      backgroundColor: Palette.kDeliveryColor,
                      userRoles: UserRoles.delivery,
                      isSelected: userRole == UserRoles.delivery ? true : false,
                      onChanged: (val) {
                        log("Current user role2:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sumit
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: CustomButton(
              title: Strings.select.tr(),
              onPressed: () async {
                await SessionManager()
                    .setData(ApiConstants.roleKey, userRole.name);

                context.navigatePush(ChooseLoginRegisterScreen(role: userRole));
              },
            ),
          ),

          /// * login guest
          TextButton(
              onPressed: () {
                pushPage(context, const HomeScreen());
              },
              child: Text(
                Strings.guest,
                style: TextStyles.textStyleFontBold20mainColor,
              )),
          verticalSpace(50.h)
        ],
      ),
    );
  }
}

class ChooseUserRoleButton extends StatelessWidget {
  const ChooseUserRoleButton({
    Key? key,
    this.userRoles = UserRoles.client,
    required this.title,
    required this.backgroundColor,
    required this.onChanged,
    required this.isSelected,
  }) : super(key: key);

  final UserRoles userRoles;
  final String title;
  final Color backgroundColor;
  final ValueChanged<UserRoles> onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(
        horizontal: context.getHorizontalPadding(),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: backgroundColor,
            borderRadius: AppRadius.r10,
            child: InkWell(
              borderRadius: AppRadius.r10,
              onTap: () => onChanged(userRoles),
              child: SizedBox(
                width: context.wSize,
                height: AppSize.s50,
                child: Center(
                  child: Text(
                    title,
                    style: context.titleM.copyWith(
                      color: Palette.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.directional(
            textDirection: context.direction(),
            start: AppSize.s10,
            child: Checkbox(
              // value: false,
              value: true,
              shape: const CircleBorder(),
              checkColor: isSelected ? Palette.mainColor : Colors.transparent,
              onChanged: (val) {},
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Palette.white;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
