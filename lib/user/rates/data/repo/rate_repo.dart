import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/user/rates/data/models/add_rate_body_model.dart';
import 'package:wajed_app/user/rates/data/models/rate_model.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/strings.dart';

abstract class BaseRate{
  Future<ApiResult<AddRateResponse>> addRate(AddRateBodyModel rateBody);
  
}

class RateRepo implements BaseRate{
  @override
  Future<ApiResult<AddRateResponse>> addRate(AddRateBodyModel rateBody) async  {
    
    var data = FormData.fromMap(rateBody.toJson());

    var response = await DioFactory.dio!.request(
     ApiConstants.addRatePath,
      options: Options(
        method: 'POST',
       
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddRateResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}