import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'dart:ui' as ui;
import '../../../../../core/common_widgets/custom_button.dart';
import '../../../../../core/constants/layout/app_assets.dart';
import '../../../../../core/constants/layout/app_radius.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../core/utils/strings.dart';
import '../../bloc/cubit/auth_cubit/auth_cubit.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  final UserRoles role;
  const LoginWithPhoneScreen({super.key, required this.role});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = const OutlineInputBorder(
      borderRadius: AppRadius.r10,
      borderSide: BorderSide.none,
    );
    return Scaffold(
        backgroundColor:
            isClaint(widget.role) ? Palette.mainColor : Palette.restaurantColor,
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
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getHorizontalPadding(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.appLogoInArabic),
                    const SizedBox(height: AppSize.s12),
                    Text(
                     Strings.inputPhone.tr(),
                      style: context.titleL.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSize.s24),
                    Form(
                      child: SizedBox(
                        width: context.wSize,
                        child: Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: TextFormField(
                            controller: _phoneController,
                            autofocus: true,
                            maxLength: 9,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,

                              // LengthLimitingTextInputFormatter(9),
                              // CustomNumberFormater(),
                            ],
                            // textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              height: 1.2,
                              fontFamily: "",
                              color: Palette.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: outlineInputBorder,
                              errorBorder: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                              disabledBorder: outlineInputBorder,
                              focusedErrorBorder: outlineInputBorder,
                              fillColor: Palette.white,
                              filled: true,
                              isDense: true,
                              hintStyle: const TextStyle(
                                height: 1.2,
                                fontFamily: "",
                              ),
                              hintTextDirection: ui.TextDirection.rtl,
                              suffixIcon: const CountryCodeWidget(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
                    // provider.isLoading
                    //     ? const CustomCircularProgress()
                    //     :

                    CustomButton(
                      title:Strings.send.tr(),
                      titleColor:isClaint(widget.role)? Palette.white:Colors.black,
                      elevation: 0.0,
                      backgroundColor: isClaint(widget.role)? Palette.kOrangeColor:Palette.kYellowColor,
                      onPressed: () async {
                        if (_phoneController.text.isNotEmpty &&
                            _phoneController.text.length >= 9) {
                          debugPrint("+966${_phoneController.text.trim()}");
                          AuthCubit.get(context).emitCheckUserName(widget.role,
                              context: context,
                              userName: "+966${_phoneController.text.trim()}", );
                        } else {
                          final snackBar = SnackBar(
                            content: Text(Strings.inputPhoneCorrectly.tr()),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 1.0,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: AppSize.s20,
        ),
        child: Text(
          "+966",
          textDirection: ui.TextDirection.rtl,
          style: context.titleM.copyWith(
            height: 1.2,
            color: Palette.mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: "",
          ),
        ),
      ),
    );
  }
}
