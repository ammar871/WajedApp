import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajed_app/common/auth/bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:wajed_app/common/auth/ui/login/login_screen.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/common_widgets/animations/custom_slide_animation.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/services/services_locator.dart';
import '../reigister/registration_screen.dart';

class ChooseLoginRegisterScreen extends StatelessWidget {
  final UserRoles role;
  const ChooseLoginRegisterScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:isClaint(role)? Palette.mainColor:Palette.restaurantColor,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            pop(context);
          },
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getHorizontalPadding(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AppSize.s200,
                // color: Colors.black26,
                child: SvgPicture.asset(AppAssets.logoWhite),
              ),
              const SizedBox(height: AppSize.s14),
              CustomSlideAnimation(
                isRight: true,
                child: CustomButton(
                  onPressed: () {
                    // appRoute.push(ClientPath.loginWithPhone, extra: false);
                    // appRoute.push(GlobalPath.chooseUserType);
                    context.navigatePush(BlocProvider(
                      create: (context) => sl<AuthCubit>(),
                      child:  LoginWithPhoneScreen(role: role,),
                    ));
                  },
                  title: Strings.login.tr(),
                  titleColor: Palette.restaurantColor,
                  backgroundColor: Palette.white,
                ),
              ),
              const SizedBox(height: AppSize.s14),
              CustomSlideAnimation(
                isRight: false,
                child: CustomButton(
                  onPressed: () {
                    // appRoute.push(ClientPath.loginWithPhone, extra: true);

                    context.navigatePush(RegistrationScreen(role: role,));
                  },
                  title:  Strings.newAccount.tr(),
                  backgroundColor: isClaint(role)? Palette.mainColor:Palette.restaurantColor,
                  borderSide: const BorderSide(
                    color: Palette.white,
                    width: AppSize.s1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
