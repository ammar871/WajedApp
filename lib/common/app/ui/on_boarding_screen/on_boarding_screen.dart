import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wajed_app/common/app/ui/change_language/choose_language_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';


import '../../../../core/constants/layout/app_assets.dart';
import '../../../../market/market/data/models/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: "assets/images/onboarding/guide1.svg",
      title: Strings.boaringT1.tr(),
      description:
          Strings.boaringd1.tr(),
    ),
    OnBoardingModel(
      image: "assets/images/onboarding/guide2.svg",
    title: Strings.boaringT2.tr(),
      description:
          Strings.boaringd2.tr(),
    ),
    OnBoardingModel(
      image: "assets/images/onboarding/guide3.svg",
      title: Strings.boaringT3.tr(),
      description:
          Strings.boaringd3.tr(),
    ),
    OnBoardingModel(
      image: "assets/images/onboarding/guide4.svg",
     title: Strings.boaringT4.tr(),
      description:
          Strings.boaringd4.tr(),
    ),
  ];

  final _controllerPage = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // * logo
          Container(
            height: context.height / 4.5,
            width: context.width,
            padding: EdgeInsets.only(top: 70.h),
            color: Palette.mainColor,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssets.logoWhite),
          ),
          Expanded(
              child: PageView(
                controller: _controllerPage,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            children: onBoardingList
                .map((e) => Container(
                      padding: const EdgeInsets.all(30).w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          SvgPicture.asset(
                            e.image,
                            fit: BoxFit.cover,
                          ),
                          verticalSpace(100.h),
                          Text(
                            e.title,
                            style: TextStyles.textStyleFontBold20mainColor
                                .copyWith(height: 1),
                          ),
                          verticalSpace(10.h),
                          Text(
                            e.description,
                            textAlign: TextAlign.center,
                            style: TextStyles.textStyleFontRegular16greyColor
                                .copyWith(height: 1),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )),
          //* buttons
          Container(
            padding: const EdgeInsets.all(30).w,
            child: Column(children: [
              ///* indicator
              AnimatedSmoothIndicator(
                activeIndex: currentPage,
                curve: Curves.linear,
                count: onBoardingList.length,
                effect: const WormEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  dotColor: Palette.kDarkGrey,
                  activeDotColor: Palette.mainColor,
                  strokeWidth: 2,
                  radius: 20,
                ),
              ),
              verticalSpace(50.h),
              CustomButton(
                  title: currentPage == 3 ? Strings.start.tr() :  Strings.next.tr(),
                  onPressed: () {
                    if (currentPage == 3) {
                      context.navigatePush(const ChooseLanguageScreen());
                   
                    } else {
                   
                      currentPage++;
                      _controllerPage.animateToPage(currentPage,
                  duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      setState(() {});
                    }
                  }),
              TextButton(
                  onPressed: () {},
                  child: Text(
                   Strings.guest.tr(),
                    style: const TextStyle(color: Palette.mainColor),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
