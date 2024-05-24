import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/app/ui/splash/splash_screen.dart';
import 'package:wajed_app/common/category/ui/categories_screen/categories_screen.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/router/routes.dart';
import 'package:wajed_app/core/routing/paths.dart';
import 'package:wajed_app/user/favoraite/ui/favoraites_screen/favoraites_screen.dart';

import 'common/alerts/ui/alerts_screen/alerts_screen.dart';
import 'common/app/ui/call_us_screen/call_us_screen.dart';
import 'common/app/ui/change_language/choose_language_screen.dart';
import 'common/app/ui/customers_service_screen/customers_service_screen.dart';
import 'common/app/ui/on_boarding_screen/on_boarding_screen.dart';
import 'common/app/ui/usage_policy_screen/usage_policy_screen.dart';
import 'common/auth/ui/choose_user_type_screen/choose_user_type_screen.dart';
import 'common/chate/ui/conversations_screen/conversations_screen.dart';
import 'common/order/ui/orders_screen/orders_screen.dart';
import 'core/constants/layout/app_fonts.dart';
import 'core/constants/layout/app_sizes.dart';
import 'driver/ui/home_driver_screen/home_driver_screen.dart';
import 'market/home/ui/navigation_screen/navigation_screen.dart';
import 'market/home/ui/settings_screen/settings_screen.dart';
import 'user/home/ui/home_screen/home_screen.dart';

class WajedApp extends StatelessWidget {

  const WajedApp({super.key});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
      designSize: const Size(414, 1118),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          title: "wajed_app",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          initialRoute: GlobalPath.splash,
          routes: {
            GlobalPath.splash: (context) => const SplashScreen(),
            GlobalPath.chooseLanguage: (context) =>
                const ChooseLanguageScreen(),
            ClientPath.homeUser: (context) => const HomeScreen(),
            ClientPath.homeMarket: (context) => const NavigationScreen(),
            GlobalPath.chooseUserType: (context) =>
                const ChooseUserTypeScreen(),
            Routes.myOrders: (context) => const OrdersScreen(),
            GlobalPath.onBoarding: (context) => const OnBoardingScreen(),
            Routes.policay: (context) => const UsagePolicyScreen(),
            Routes.help: (context) => const CustomersServiceScreen(),
            Routes.settings: (context) => const SettingsScreen(),
            ClientPath.homeDriver: (context) => const HomeDriverScreen(),
            Routes.conersations: (context) => const ConversationsScreen(),
            Routes.alertsScreen: (context) => const AlertsScreen(),
            Routes.callUs: (context) => const CallUsScreen(),
             Routes.faves: (context) => const FavoraitesScreen(),
             Routes.categories: (context) => const CategoriesScreen(),
          }),
    );
  }
}

ThemeData lightTheme(BuildContext context) {
  // final currentLang = prefs.getString(AppConstants.langugageCode);
  return ThemeData(
    // useMaterial3: true,
    scaffoldBackgroundColor: Palette.white,
    // primaryColor: Palette.restaurantColor,
    splashFactory: InkRipple.splashFactory,
    fontFamily: AppFonts.stc,
    // currentLang == AppConstants.ar ? AppFonts.stc : AppFonts.montserrat,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Palette.mainColor,
        ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Palette.mainColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.white,
      elevation: AppSize.s5,
      shadowColor: Color(0x9AF1F1F1),
      iconTheme: IconThemeData(
        color: Palette.kDarkGrey,
      ),
      titleTextStyle: TextStyle(
        color: Palette.kDarkGrey,
        fontFamily: AppFonts.stc,
        fontSize: AppSize.s20,
      ),
    ),
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Palette.restaurantColor,
    // ),
  );
}

