import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:wajed_app/core/enums/user_roles.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../common/auth/bloc/cubit/auth_cubit/auth_cubit.dart';
import '../common_widgets/custom_button.dart';
import '../constants/layout/palette.dart';
import '../enums/loading_status.dart';
import '../routing/paths.dart';
import '../services/services_locator.dart';
import '../utils/api_constatns.dart';
import '../utils/app_model.dart';
import 'session_manager.dart';

pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

isAraic() {
  return AppModel.lang == AppModel.arLang;
}

isEnglish() {
  return AppModel.lang == AppModel.engLang;
}

isClaint(role) {
  return role == UserRoles.client;
}

/// =========================== loctaion
Position locData = Position.fromMap({});
double? currentLat;
double? currentLng;

PermissionStatus? permissionGranted;
Future getLocation() async {
  Location location = Location();
  bool serviceEnabled;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  await locateUser();
}

Future locateUser() async {
  locData = await Geolocator.getCurrentPosition();

  /// get lat and lng for passing to homeApi user ;

  if (currentLat == null) {
    currentLat = locData.latitude;
    debugPrint("Saved ============================================>  latitude");
  }
  if (currentLng == null) {
    currentLng = locData.longitude;
    debugPrint(
        "Saved ============================================>  longitude");
  }

  debugPrint(
      "${locData.latitude}============================================>  location");
}

bool isLogin() {
  return currentUser != null && currentUser!.token != "";
}

pop(context) {
  Navigator.pop(context);
}

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

showToast({msg, color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

// Future saveData(key, value) async {
//   const storage = FlutterSecureStorage();
//   storage.write(key: key, value: value);
// }

/// * bootm sheet widget
void showBottomSheetWidget(context, child) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return child;
      });
}

/// * show pop menu
showPopMenu({context, items, key, postion}) {
  showMenu(
    items: items,
    context: context,
    position: postion,
  );
}


// ===========================
void showDialogWidget(BuildContext context, Widget child) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: child,
      );
    },
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

void deleteDataDialog({title, value, context, onDelete}) {
  showDialogWidget(
      context,
      Container(
          padding: const EdgeInsets.all(20).w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              title,
              style: TextStyle(color: Colors.red, fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  title: Strings.delete.tr(),
                  onPressed: onDelete,
                  backgroundColor: Colors.red,
                  titleColor: Colors.white,
                )),
                horizontalSpace(20.w),
                Expanded(
                    child: CustomButton(
                  title: Strings.cancel.tr(),
                  onPressed: () {
                    pop(context);
                  },
                  backgroundColor: Colors.white,
                  titleColor: Colors.black,
                )),
              ],
            )
          ])));
}

/// * ===========================    chang lang
// ==================== delete account

Future deleteAccountDialog(BuildContext context, {onDelete}) async {
  showDialog(
    context: context,
    builder: (context) {
      // return object of type Dialog
      return Container(
        // height: 200,
        child: AlertDialog(
          content: Expanded(
              child: Text(
            Strings.descDeleteAccount.tr(),
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(Strings.ok.tr(),
                  style: const TextStyle(color: Colors.red)),
              onPressed: onDelete,
            ),
          ],
        ),
      );
    },
  );
}

void showDialogDeleteAccount({contextPage}) {
  showDialog<void>(
    context: contextPage,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext dialogContex) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          Strings.deleteAccount.tr(),
          style: TextStyle(fontSize: 20, color: Palette.mainColor),
        ),
        content: Container(
          width: widthScreen(contextPage),
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      Strings.areYouSureDeleteAccount.tr(),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: state.deleteAccountState == RequestState.loading
                            ? CircularProgressIndicator()
                            : CustomButton(
                                elevation: 0,
                                backgroundColor: Palette.mainColor,
                                titleColor: Colors.white,
                                onPressed: () async {
                                  pop(context);
                                  AuthCubit.get(context)
                                      .deleteAccount(context: contextPage);
                                 
                                },
                                title: Strings.yes.tr(),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomButton(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        titleColor: Colors.red,
                        onPressed: () async {
                          pop(dialogContex);
                        },
                        title: Strings.cancel.tr(),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      );
    },
  );
}

void showChangeLangDialog(BuildContext context) {
  showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          Strings.changeLang.tr(),
          style: const TextStyle(fontSize: 20, color: Palette.mainColor),
        ),
        content: SizedBox(
          width: widthScreen(context),
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      Strings.areYouSureLang.tr(),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  elevation: 0,
                  backgroundColor: Palette.mainColor,
                  titleColor: Colors.white,
                  onPressed: () async {
                    if (AppModel.lang == AppModel.engLang) {
                      AppModel.lang = AppModel.arLang;
                      context.setLocale(Locale(AppModel.arLang));
                      await SessionManager()
                          .setData(ApiConstants.langKey, AppModel.arLang);
                      context.navigatePop();
                      context.navigateToNamed(GlobalPath.splash);
                    } else {
                      AppModel.lang = AppModel.engLang;
                      context.setLocale(Locale(AppModel.engLang));
                      await SessionManager()
                          .setData(ApiConstants.langKey, AppModel.engLang);
                      context.navigatePop();
                      context.navigateToNamed(GlobalPath.splash);
                    }
                  },
                  title: Strings.change.tr(),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  titleColor: Colors.red,
                  onPressed: () async {
                    context.navigatePop();
                  },
                  title: Strings.cancel.tr(),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}


/// pick image 