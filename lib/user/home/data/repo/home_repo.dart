import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/dio_factory.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/home/data/models/home_user_response.dart';

import '../../../../core/network/api_result.dart';

abstract class BaseHomeUser {
  Future<ApiResult<HomeUserResponse>> getHomeUser(String userId);
}

class HomeUserRepo implements BaseHomeUser {
  @override
  Future<ApiResult<HomeUserResponse>> getHomeUser(String userId) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.homeUserPath}UserId=$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(HomeUserResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
