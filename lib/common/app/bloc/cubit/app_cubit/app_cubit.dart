import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/helpers/firebase_manger.dart';
import 'package:wajed_app/core/helpers/session_manager.dart';

import 'package:wajed_app/market/home/ui/navigation_screen/navigation_screen.dart';
import 'package:wajed_app/user/home/ui/home_screen/home_screen.dart';

import '../../../../../core/helpers/helper_functions.dart';

import '../../../../../core/routing/paths.dart';
import '../../../../../core/utils/api_constatns.dart';
import '../../../../../core/utils/app_model.dart';
import '../../../../../driver/ui/home_driver_screen/home_driver_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  changeLang(lang, context) async {
    AppModel.lang = lang;
    await SessionManager().setData(ApiConstants.langKey, lang);
    // EasyLocalization.of(context)?.setLocale(Locale(lang, ''));

    pushPageRoutName(context, GlobalPath.chooseUserType);
    emit(AppState(changLang: lang));
  }

  getLang() {
    if (AppModel.lang == "") {
      emit(const AppState(changLang: "ar"));
    } else {
      emit(AppState(changLang: AppModel.lang));
    }
  }

  getPage(context) {
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint(AppModel.lang);
      FCMManger().getFCMToken();
      if (AppModel.lang == "") {
        // context.navigateToNamed(selectLang);
        pushPageRoutName(context, GlobalPath.onBoarding);
      } else {
        if (isLogin()) {
          if (AppModel.currentRole == UserRoles.client.name) {
            pushPage(context, const HomeScreen());
          } else if (AppModel.currentRole == UserRoles.restaurant.name) {
            pushPage(context, const NavigationScreen());
          } else {
            pushPage(context, const HomeDriverScreen());
          }
        } else {
          pushPageRoutName(context, GlobalPath.chooseUserType);
        }
      }
      emit(const AppState(page: "done"));
    });
  }
}
