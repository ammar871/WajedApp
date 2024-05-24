import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wajed_app/common/auth/data/repo/auth_repo.dart';

import 'package:wajed_app/common/auth/ui/verification_screen/verification_screen.dart';
import 'package:wajed_app/core/enums/user_roles.dart';

import 'package:wajed_app/core/routing/paths.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../../core/enums/loading_status.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/helpers/session_manager.dart';
import '../../../../../core/services/services_locator.dart';

import '../../../../../core/utils/utils.dart';

import '../../../data/models/login_request_body.dart';
import '../../../data/models/register_response.dart';
import '../../../data/models/signup_request_body.dart';
import '../../../data/models/user_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuth _loginRepo;
  AuthCubit(this._loginRepo) : super(const AuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  /// ================================================================ CheckUserName
  void emitCheckUserName(UserRoles role, {userName, context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(registerUserState: RequestState.loading));
    final response = await _loginRepo.checkUserName(userName, role.name);

    response.when(success: (authResponse) {
      debugPrint("${authResponse.status} emitCheckUserName");

      /// user fined
      if (authResponse.status) {
        pop(context);
        pushPage(
            context,
            BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: VerificationScreen(
                phoneNumber: userName,
                verificationCode: authResponse.code,
                userRoles: role,
              ),
            ));
        emit(state.copyWith(
          loginUserState: RequestState.loaded,
        ));

        /// user not fined
      } else {
        pop(context);

        if (authResponse.code == "0") {
          showToast(
              color: Colors.red, msg: Strings.isReqisterWithOtherAccount.tr());

          emit(state.copyWith(
            loginUserState: RequestState.loaded,
          ));
        } else {
          showToast(color: Colors.red, msg: Strings.isReqistered.tr());

          emit(state.copyWith(
            loginUserState: RequestState.loaded,
          ));
        }
      }
    }, failure: (code, error) {
      pop(context);
      debugPrint("$code=========> emitCheckUserName");
      showErrorLoading(context, Strings.someError.tr());
      emit(state.copyWith(registerUserState: RequestState.error));
    });
  }

  /// ================================================================ signUp
  void signUp(SignUpRequestBody signUpRequestBody, {context, role}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(registerUserState: RequestState.loading));
    final response = await _loginRepo.signUp(signUpRequestBody);

    response.when(success: (authResponse) {
      debugPrint("success");
      Navigator.of(context).pop();
      if (authResponse.status) {
        pushPage(
            context,
            BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: VerificationScreen(
                  phoneNumber: signUpRequestBody.userName,
                  userRoles: role,
                  verificationCode: authResponse.code),
            ));
      } else {
        showToast(color: Colors.red, msg: authResponse.code.tr());
      }
      emit(state.copyWith(registerUserState: RequestState.loaded));
    }, failure: (code, error) {
      pop(context);
      debugPrint("$code=========> emitCheckUserName");

      showErrorLoading(context, Strings.someError.tr());
      emit(state.copyWith(registerUserState: RequestState.error));
    });
  }

  /// ================================================================ loginUser
  void loginUser(LoginReqeustBody loginReqeustBody, UserRoles role,
      {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(
      loginUserState: RequestState.loading,
    ));
    final response = await _loginRepo.loginUser(loginReqeustBody);

    response.when(success: (authResponse) async {
      debugPrint("${authResponse.token} loginUser");
      currentUser = authResponse;
      AppModel.currentRole = role.name;
      await SessionManager().setUserData(authResponse.toJson());
      pop(context);
      if (role == UserRoles.client) {
        pushPageRoutName(context, ClientPath.homeUser);
      } else if (role == UserRoles.restaurant) {
        pushPageRoutName(context, ClientPath.homeMarket);
      } else {
        pushPageRoutName(context, ClientPath.homeDriver);
      }
      emit(state.copyWith(
          loginUserState: RequestState.loaded,
          userResponseModel: authResponse));
    }, failure: (code, error) {
      debugPrint("$code=========> emitCheckUserName");
      pop(context);
      showErrorLoading(context, Strings.someError.tr());
      emit(state.copyWith(
        loginUserState: RequestState.error,
      ));
    });
  }

  Future deleteAccount({context}) async {
    emit(state.copyWith(deleteAccountState: RequestState.loading));
    final response = await _loginRepo.deleteAccount();
    response.when(success: (data) {
      showToast(msg: data, color: Colors.green);
      SessionManager().singOut(context: context);
      debugPrint("deleteAccount");
      emit(state.copyWith(deleteAccountState: RequestState.loaded));
    }, failure: (code, error) {
      showToast(msg: error, color: Colors.red);
      emit(state.copyWith(deleteAccountState: RequestState.error));
    });
  }
}
