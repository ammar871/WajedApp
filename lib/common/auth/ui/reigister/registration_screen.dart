import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajed_app/common/auth/data/models/signup_request_body.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_utils.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../../core/common_widgets/custom_button.dart';
import '../../../../../core/constants/layout/app_assets.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/helper_functions.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../core/enums/user_roles.dart';
import '../../bloc/cubit/auth_cubit/auth_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.role});

  final UserRoles role;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _codeController,
      _phoneController,
      _fullNameController,
      _emailController,
      _refCodeController;

  bool acceptePraivacy = true;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: "+966");
    _phoneController = TextEditingController();

    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _refCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color:
          isClaint(widget.role) ? Palette.mainColor : Palette.restaurantColor,
      fontWeight: FontWeight.bold,
    );
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, authProvider) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: CustomButton(
                title: Strings.register.tr(),
                backgroundColor: isClaint(widget.role)
                    ? Palette.mainColor
                    : Palette.restaurantColor,
                onPressed: () async {
                  if (validate(context)) {
                    AuthCubit.get(context).signUp(
                        SignUpRequestBody(
                          city: _refCodeController.text,
                          userName: _codeController.text.trim() +
                              _phoneController.text.trim(),
                          role: widget.role.name,
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          password: 'Abc133@',
                        ),
                        context: context,
                        role: widget.role);
                  }
                  // log("authProvider.isLoading:: ${authProvider.isLoading} ##");

                  // if (authProvider.isLoading) {
                  //   circularDialog(context);
                  // } else {
                  //   // context.pop();
                  // }
                  // final RegisterUserModel userModel = RegisterUserModel(
                  //   userName: _phoneController.text.trim(),
                  //   fullName: _fullNameController.text,
                  //   email: _emailController.text,
                  //   password: "",
                  //   role: "user",
                  //   city: "",
                  // );
                  // context.read<AuthCubit>().registration(userModel);
                },
              ),
            ),
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    padding: const EdgeInsets.only(bottom: AppSize.s20),
                    decoration: BoxDecoration(
                      color: isClaint(widget.role)
                          ? Palette.mainColor
                          : Palette.restaurantColor,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 50.h),
                            child: BackButton(
                              onPressed: () {
                                pop(context);
                              },
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                            AppAssets.logoWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Form(
                      child: SingleChildScrollView(
                        padding: listViewPadding(context),
                        child: Column(
                          children: [
                            // phon number
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  
                                  child: TextFormField(
                                    controller: _codeController,
                                    keyboardType: TextInputType.number,
                                    enabled: false,
                                    readOnly: true,
                                    maxLength: 4,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    decoration: InputDecoration(
                                      label: Text(
                                        Strings.countryCode.tr(),
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
maxLength: 9,
                                    // readOnly: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      // LengthLimitingTextInputFormatter(9),
                                      // CustomNumberFormater(),
                                    ],
                                    decoration: InputDecoration(
                                      label: Text(
                                        Strings.mobileNumber.tr(),
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _fullNameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                label: Text(
                                  Strings.yourName.tr(),
                                  style: textStyle,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                label: Text(
                                  Strings.email.tr(),
                                  style: textStyle,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _refCodeController,
                              decoration: InputDecoration(
                                label: Text(
                                  Strings.city.tr(),
                                  style: textStyle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CheckBoxWidget(
                              onChanged: (vall) {
                                acceptePraivacy = !acceptePraivacy;
                                setState(() {});
                              },
                              acceptePraivacy: acceptePraivacy,
                                title: Strings.registrationTerms.tr(),
                                style:
                                    TextStyles.textStyleFontRegular12greyColor,
                                backgroundColor: isClaint(widget.role)
                                    ? Palette.mainColor
                                    : Palette.restaurantColor),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool validate(BuildContext context) {
    if (_phoneController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputPhone.tr());
      return false;
    } else if (_fullNameController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputName.tr());

      return false;
    } else if (_emailController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputEmail.tr());

      return false;
    } else if (_refCodeController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputCity.tr());

      return false;
    }else if (!acceptePraivacy) {
      showToast(color: Colors.red, msg: Strings.acceptPrivacy.tr());

      return false;
    } else {
      return true;
    }
  }
}

class CheckBoxWidget extends StatelessWidget {
  final bool acceptePraivacy;
  final String title;
  final Color backgroundColor;
  final TextStyle style;
  final Function(bool?)? onChanged;
  const CheckBoxWidget({
    super.key,
    required this.backgroundColor,
    required this.title,required this.onChanged,
    required this.style, required this.acceptePraivacy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            onChanged:onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            checkColor: Palette.white,
            fillColor: MaterialStateProperty.all(backgroundColor),
            value: acceptePraivacy,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
