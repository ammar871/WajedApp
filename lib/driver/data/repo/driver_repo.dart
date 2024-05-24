import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/driver/data/models/home_response_driver.dart';

import '../../../core/network/dio_factory.dart';
import '../../../core/utils/api_constatns.dart';

import '../models/add_driver_body.dart';
import '../models/driver_model.dart';

abstract class BaseDriver {
  Future<ApiResult<DriverModel>> addDriver(AddDriverBody addDriverBody);
  Future<ApiResult<HomeDriverResponse>> getHomeDriver(String userId);
}

class DriverRepo extends BaseDriver {
  @override
  Future<ApiResult<DriverModel>> addDriver(AddDriverBody addDriverBody) async {
    var data = FormData.fromMap(addDriverBody.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addDriverPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(DriverModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<HomeDriverResponse>> getHomeDriver(String userId) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.homeDrriverPath}UserId=$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(HomeDriverResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
