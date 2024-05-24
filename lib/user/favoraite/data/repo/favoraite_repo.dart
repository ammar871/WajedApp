import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/user/favoraite/data/models/add_fav_body.dart';
import 'package:wajed_app/user/favoraite/data/models/favoraite_model.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/strings.dart';
import '../models/favoraite_response.dart';

abstract class BaseFavoraite {
  Future<ApiResult<List<FavoraiteResponse>>> getFavoraites({userId});
  Future<ApiResult<FavorateModel>> addFavoraite(AddFavBody addFavBody);
}

class FavoraiteRepo extends BaseFavoraite {
  @override
  Future<ApiResult<List<FavoraiteResponse>>> getFavoraites({userId}) async {
    var response = await DioFactory.dio!.request(
     "${ApiConstants.getFavesPath}userId=$userId",
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(List.from(
          (response.data as List).map((e) => FavoraiteResponse.fromJson(e))));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<FavorateModel>> addFavoraite(AddFavBody addFavBody) async {
    var data = FormData.fromMap(addFavBody.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addFavPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(FavorateModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
