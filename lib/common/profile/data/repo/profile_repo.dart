import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/common/profile/data/models/update_peofile_body.dart';
import 'package:wajed_app/core/network/api_result.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';

abstract class BaseProfile {
  Future<ApiResult<UserModel>> getUserProfile();
  Future<ApiResult<UserModel>> editProfile(UpdateProfileBody updateProfileBody);
}

class ProfileRepo extends BaseProfile {
  @override
  Future<ApiResult<UserModel>> getUserProfile() async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getUserPath}UserId=${currentUser!.user.id}',
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(UserModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<UserModel>> editProfile(
      UpdateProfileBody updateProfileBody) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var data = FormData.fromMap(updateProfileBody.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.updateUserPath,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(UserModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
