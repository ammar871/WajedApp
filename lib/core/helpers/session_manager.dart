import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:wajed_app/common/auth/ui/choose_user_type_screen/choose_user_type_screen.dart';

import '../../common/auth/data/models/user_response.dart';

import '../utils/api_constatns.dart';
import '../utils/app_model.dart';
import 'helper_functions.dart';

class SessionManager {
  Future<void> setUserData(Map<String, dynamic> user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('userData', json.encode(user));
  }

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString('userData');
    if (data != null) {
      Map<String, dynamic> json = jsonDecode(pref.getString('userData')!);
      currentUser = UserResponse.fromJson(json);
       
    }

     AppModel.lang=pref.getString(ApiConstants.langKey)??"";
        AppModel.currentRole=pref.getString(ApiConstants.roleKey)??"";
      if (kDebugMode) {
        print("${AppModel.currentRole} role ===========");
      }

    // AppModel.lang = pref.getString('lang') ?? AppModel.arLang;
  }

  Future singOut({context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('userData');
     await pref.remove(ApiConstants.roleKey);
    currentUser = null;
    pushPage(context,const ChooseUserTypeScreen());
  }

  Future<void> setData(String key, String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(key, data);
  }
}
