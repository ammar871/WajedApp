import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/helpers/firebase_manger.dart';
import 'package:wajed_app/wajed_app.dart';
import 'core/helpers/session_manager.dart';
import 'core/services/services_locator.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();


  ///* FCM notifcation
   await Firebase.initializeApp();
   await FCMManger().initFCM();
  /// * localizations
  await EasyLocalization.ensureInitialized();

  /// * dependenjctions
  await ServicesLocator().init();


  ///* responsive screens
  await ScreenUtil.ensureScreenSize();

  ///* local storage
  await SessionManager().getUserData();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/i18n",
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: const WajedApp()),
  );
}

