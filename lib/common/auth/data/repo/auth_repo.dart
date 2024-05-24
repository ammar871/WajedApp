import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/core/network/dio_factory.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import '../../../../core/network/api_result.dart';

import '../../../../core/utils/strings.dart';
import '../models/auth_response.dart';
import '../models/login_request_body.dart';
import '../models/signup_request_body.dart';

abstract class BaseAuth {
  Future<ApiResult<AuthResponse>> checkUserName(
      String phoneNumber, String role);

  Future<ApiResult<AuthResponse>> signUp(SignUpRequestBody signUpRequestBody);

  Future<ApiResult<UserResponse>> loginUser(LoginReqeustBody loginReqeustBody);

  Future<ApiResult<String>> deleteAccount();
}

class AuthRepo implements BaseAuth {
  @override
  Future<ApiResult<AuthResponse>> checkUserName(
      String phoneNumber, String role) async {
    var data = FormData.fromMap({'userName': phoneNumber, "role": role});

    final response = await DioFactory.dio!.request(
      ApiConstants.checkUserPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AuthResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<UserResponse>> loginUser(
      LoginReqeustBody loginReqeustBody) async {
    var data = FormData.fromMap(loginReqeustBody.toJson());

    final response = await DioFactory.dio!.request(
      ApiConstants.loginPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(UserResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> signUp(
      SignUpRequestBody signUpRequestBody) async {
    var data = FormData.fromMap(signUpRequestBody.toJson());

    final response = await DioFactory.dio!.request(
      ApiConstants.signUpPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AuthResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
  
  @override
  Future<ApiResult<String>> deleteAccount()async {
   var data = FormData.fromMap({"userId":currentUser!.user.id});

    final response = await DioFactory.dio!.request(
      ApiConstants.deleteAccountPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(Strings.deleteAccountSuccess.tr());
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
// final ApiService _apiService;
// AuthRepo(this._apiService);
//
// Future<ApiResult<AuthResponse>> checkUserName(String phoneNumber) async{
//   try {
//     final response = await _apiService.checkUsername(phoneNumber);
//     return ApiResult.success(response);
//   } catch (error) {
//     return ApiResult.failure(error.toString());
//   }
// }
//
// Future<ApiResult<AuthResponse>> signUp(
//     SignUpRequestBody signUpRequestBody) async {
//   try {
//     final response = await _apiService.signUp(signUpRequestBody);
//     return ApiResult.success(response);
//   } catch (error) {
//     return ApiResult.failure(error.toString());
//   }
// }
//
// Future<ApiResult<UserResponse>> loginUser(LoginReqeustBody loginReqeustBody) async{
//   try {
//     final response = await _apiService.loginUser(loginReqeustBody);
//     return ApiResult.success(response);
//   } catch (error) {
//     return ApiResult.failure(error.toString());
//   }
// }
}
