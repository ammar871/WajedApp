import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/alerts/data/models/alert_respone.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class  BaseAlert{

  Future<ApiResult<AlertResponse>> getAlerts({userId,page});
}

class AlertsRepo extends BaseAlert {
  @override
  Future<ApiResult<AlertResponse>> getAlerts({userId,page}) async {
      var response = await DioFactory.dio!.request(
      '${ApiConstants.getAlertsPath}userId=$userId&page=$page',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AlertResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}