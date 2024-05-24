import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/app/data/models/menu_model.dart';

import 'package:wajed_app/common/auth/ui/choose_user_type_screen/choose_user_type_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/router/routes.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/ui/settings_screen/settings_screen.dart';
import 'package:wajed_app/user/cart/ui/components/divider_widget.dart';
import '../../constants/layout/palette.dart';
import '../../helpers/session_manager.dart';
import '../../helpers/spacing.dart';
import '../../theming/styles.dart';
import 'components/container_select_account.dart';
import 'components/user_data_drawer.dart';

class DraweWidget extends StatelessWidget {
  DraweWidget({
    super.key,
  });

//* list items menu items user
  final List<MenuItemModel> itemsMenuUser = [
    // MenuItemModel(
    //     name: "خيارات الدفع".tr(),
    //     route: Routes.paymentMethodes,
    //     icon: "assets/icons/pay.svg"),
    MenuItemModel(
        name: Strings.walet.tr(), route: "no", icon: "assets/icons/wallet.svg"),
    MenuItemModel(
        name: Strings.conversations.tr(),
        route: Routes.conersations,
        icon: 'assets/icons/message_menu.svg'),

    MenuItemModel(
        name: Strings.myOrders.tr(),
        route: Routes.myOrders,
        icon: "assets/icons/order.svg"),
    MenuItemModel(
        name: Strings.alerts.tr(),
        route: Routes.alertsScreen,
        icon: "assets/icons/noty.svg"),
    MenuItemModel(
        name: Strings.faves.tr(),
        route: Routes.faves,
        icon: 'assets/icons/fav_menu.svg'),
    MenuItemModel(
        name: Strings.policyUsage.tr(),
        route: Routes.policay,
        icon: "assets/icons/policy.svg"),
    MenuItemModel(
        name: Strings.coustmersService.tr(),
        route: Routes.help,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.callUs.tr(),
        route: Routes.callUs,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.settings.tr(),
        route: Routes.settings,
        icon: "assets/icons/settings.svg"),
    MenuItemModel(
        name: Strings.rateServices.tr(),
        route: Routes.policay,
        icon: "assets/icons/noty.svg"),
    MenuItemModel(
        name: Strings.english.tr(),
        route: Routes.lang,
        icon: "assets/icons/lang.svg"),
    MenuItemModel(
        name: Strings.logOut.tr(),
        route: Routes.logOut,
        icon: "assets/icons/logout.svg"),
    
  ];

//* list items menu items market
  final List<MenuItemModel> itemsMenuMarket = [
    // MenuItemModel(
    //     name: Strings.orders.tr(),
    //     route: Routes.myOrders,
    //     icon: "assets/icons/order.svg"),
    MenuItemModel(
        name: Strings.conversations.tr(),
        route: Routes.conersations,
        icon: 'assets/icons/message_menu.svg'),
    MenuItemModel(
        name: Strings.policyUsage.tr(),
        route: Routes.policay,
        icon: "assets/icons/policy.svg"),
    MenuItemModel(
        name: Strings.coustmersService.tr(),
        route: Routes.help,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.callUs.tr(),
        route: Routes.callUs,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.english.tr(),
        route: Routes.lang,
        icon: "assets/icons/lang.svg"),
    MenuItemModel(
        name: Strings.logOut.tr(),
        route: Routes.logOut,
        icon: "assets/icons/logout.svg"),

  ];

//* list items menu items market
  final List<MenuItemModel> itemsMenuDriver = [
    // MenuItemModel(
    //     name: "الطلبات".tr(),
    //     route: Routes.myOrders,
    //     icon: "assets/icons/order.svg"),
    MenuItemModel(
        name: Strings.conversations.tr(),
        route: Routes.conersations,
        icon: 'assets/icons/message_menu.svg'),
    MenuItemModel(
        name: Strings.policyUsage.tr(),
        route: Routes.policay,
        icon: "assets/icons/policy.svg"),
    MenuItemModel(
        name: Strings.coustmersService.tr(),
        route: Routes.help,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.settings.tr(),
        route: Routes.settings,
        icon: "assets/icons/settings.svg"),
    MenuItemModel(
        name: Strings.rateServices.tr(),
        route: Routes.policay,
        icon: "assets/icons/noty.svg"),
    MenuItemModel(
        name: Strings.callUs.tr(),
        route: Routes.callUs,
        icon: "assets/icons/help.svg"),
    MenuItemModel(
        name: Strings.english.tr(),
        route: Routes.lang,
        icon: "assets/icons/lang.svg"),
    MenuItemModel(
        name: Strings.logOut.tr(),
        route: Routes.logOut,
        icon: "assets/icons/logout.svg"),

 
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: context.width / 1.3,
        backgroundColor: isClaint(UserRoles.values.byName(AppModel.currentRole))
            ? Palette.mainColor
            : Palette.restaurantColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(100.h),

                /// * ===============  icon Back
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                          size: 30.w,
                        )),
                  ],
                ),

                /// * ===============   user Data
                const UserDataDrawer(), verticalSpace(50.h),

                const DividerWidget(hieght: .3, color: Colors.white),

                verticalSpace(30.h),

                /// * ================ items menu
                Column(
                  children: getListMenuDraw()
                      .map((e) => GestureDetector(
                            onTap: () async {
                              if (e.route == Routes.logOut) {
                                await SessionManager()
                                    .singOut(context: context);
                              } else if (e.route == Routes.lang) {
                                showChangeLangDialog(context);
                              } else if (e.route == Routes.settings) {
                                context.navigatePush(SettingsScreen(
                                  isNav: false,
                                ));
                              } else {
                                context.navigateToNamed(e.route);
                              }
                            },
                            child: SizedBox(
                              height: 50.h,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    e.icon,
                                  
                                    colorFilter: ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                  horizontalSpace(20.w),
                                  Text(
                                    e.name,
                                    style: TextStyles.textStyleFontBold16White
                                    .copyWith(
                                      color: e.route==Strings.deleteAccount?Colors.red:null
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )



                /// * ========================= . select Account
                ,
                verticalSpace(30.h),

                Row(
                  children: [
                    ContainerSelectAccount(
                      icon: "assets/icons/market.svg",
                      name: "الانضمام كتاجر".tr(),
                      onTap: () {
                        context.navigatePush(const ChooseUserTypeScreen());
                      },
                    ),
                    horizontalSpace(5.w),
                    ContainerSelectAccount(
                      icon: "assets/icons/driver.svg",
                      name: "الانضمام كسائق".tr(),
                      onTap: () {
                        context.navigatePush(const ChooseUserTypeScreen());
                      },
                    ),
                  ],
                )
            
              , verticalSpace(40.h),
              CustomButtonWithIcon(title: Strings.deleteAccount.tr(),
              
              backgroundColor: Colors.red,
              
               onPressed: (){
                 showDialogDeleteAccount(contextPage: context);
               }, icon: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                    height: 15.w,width: 15.w,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                  ),)
            
              ],
            ),
          ),
        ));
  }

  List<MenuItemModel> getListMenuDraw() {
    switch (currentUser!.user.role) {
      case ApiConstants.client:
        return itemsMenuUser;
      case ApiConstants.restaurant:
        return itemsMenuMarket;
      case ApiConstants.delivery:
        return itemsMenuDriver;
      default:
        return [];
    }
  }
}
