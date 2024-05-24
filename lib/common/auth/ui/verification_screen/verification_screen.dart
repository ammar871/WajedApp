import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wajed_app/common/auth/data/models/login_request_body.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'dart:ui' as ui;
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../bloc/cubit/auth_cubit/auth_cubit.dart';

class VerificationScreen extends StatefulWidget {
  final UserRoles userRoles;
  const VerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationCode, required this.userRoles,
  });

  final String phoneNumber;
  final String verificationCode;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<VerificationCubit>().get(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (ctx, state) {
        //   debugPrint("state::: $state");
        // if (state.loginUserState == RequestState.loading) {
        //   showUpdatesLoading(context);
        // } else if (state.loginUserState == RequestState.loaded) {
        //   Navigator.of(context).pop();
        // } else if (state.loginUserState == RequestState.error) {
        //   Navigator.of(context).pop();
        //   // Navigator.of(context).pop();
        //   showErrorLoading(context, 'something_went_wrong'.tr());
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:isClaint(widget.userRoles)? Palette.mainColor:Palette.restaurantColor,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.appLogoInArabic),
                const SizedBox(height: AppSize.s12),
                Text(
                  Strings.enterVerificationCode.tr(),
                  style: context.titleL.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSize.s24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: PinCodeTextField(
                      appContext: context,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      length: 4,
                      onChanged: (val) async {
                        if (val.isNotEmpty && val.length >= 4) {
                          AuthCubit.get(context).loginUser(
                         
                            LoginReqeustBody(
                                username: widget.phoneNumber,
                                deviceToken: "deviceToken",
                                code: "0000"),
                                 widget.userRoles,
                            context: context,
                            
                          );
                        }
                      },
                      pinTheme: PinTheme(
                        activeColor: Palette.white,
                        disabledColor: Palette.white,
                        inactiveColor: Palette.white,
                        selectedColor: Palette.kBlackColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s14),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.zero,
                      horizontal: AppSize.s5,
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(
                    Strings.resendVerificationCode.tr(),
                    style: context.titleM.copyWith(
                      color: Palette.white,
                    ),
                  ),
                ),
                SizedBox(
                    height: AppSize.s100,
                    child: Center(
                      child: Text(
                        "Verification Code - for test: 0000",
                        style: context.titleL.copyWith(color: Palette.white),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsetsDirectional.only(end: AppSize.s10),
        // width: 50,
        child: Text(
          "+966",
          textDirection: ui.TextDirection.ltr,
          style: context.titleM.copyWith(
            color: Palette.mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: "",
          ),
        ),
      ),
    );
  }
}
