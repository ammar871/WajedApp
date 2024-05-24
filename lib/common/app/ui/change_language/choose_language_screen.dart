import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/common_widgets/animations/custom_slide_animation.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/services/services_locator.dart';
import '../../bloc/cubit/app_cubit/app_cubit.dart';


class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("## Build - Choose language screen ##");
    return BlocProvider(
      create: (context) => sl<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Palette.mainColor,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getHorizontalPadding(),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: context.hSize * 0.50,
                        child: SvgPicture.asset(AppAssets.logoWhite),
                      ),
                      CustomSlideAnimation(
                        isRight: true,
                        child: CustomButton(
                          onPressed: () {
                            context.setLocale( Locale(AppModel.arLang));

                            AppCubit.get(context).changeLang(AppModel.arLang, context);
                          },
                          title: Strings.arabic.tr(),
                          titleColor: Palette.mainColor,
                          backgroundColor: Palette.white,
                        ),
                      ),
                      const SizedBox(height: AppSize.s14),
                      CustomSlideAnimation(
                        isRight: false,
                        child: CustomButton(
                          onPressed: () {
                            context.setLocale( Locale(AppModel.engLang));
                            AppCubit.get(context).changeLang(AppModel.engLang, context);
                          },
                          title: Strings.english.tr(),
                          borderSide: const BorderSide(
                            color: Palette.white,
                            width: AppSize.s1,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
