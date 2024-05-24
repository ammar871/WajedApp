import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/data/models/home_market_response.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class BaseHomeMarket {
  Future<ApiResult<HomeResponseMarket>> getHomeMarket(String userId);
}

class HomeMarketRepo implements BaseHomeMarket {
  @override
  Future<ApiResult<HomeResponseMarket>> getHomeMarket(String userId) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.homeMarketPath}UserId=$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(HomeResponseMarket.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
