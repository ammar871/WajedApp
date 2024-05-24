import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/market/data/models/add_market_body_request.dart';
import 'package:wajed_app/market/market/data/models/update_market_model.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';
import '../../../../core/network/dio_factory.dart';
import '../models/filter_body_request.dart';
import '../models/mareket_details_response.dart';
import '../models/market_model.dart';
import '../models/market_response.dart';

abstract class BaseMarket {
  Future<ApiResult<MarketDetailsResponse>> getMarketDetails(int marketId);

  Future<ApiResult<List<MarketModel>>> searchMarkets({textSearch, addressId});

  Future<ApiResult<MarketResponse>> getMarketsByFieldId(
      {fieldId, addressId, page});

  Future<ApiResult<MarketResponse>> filtersMarkets(
      FilterBodyRequest filterBodyRequest);

  Future<ApiResult<MarketModel>> addMarket(
      AddMarketBodyRequest addMarketBodyRequest);

  Future<ApiResult<MarketModel>> updateMarket(
      UpdateMarketModel updateMarketModel);

  Future<ApiResult<List<FieldModel>>> getFields();
}

class MarketRepo implements BaseMarket {
  @override
  Future<ApiResult<MarketDetailsResponse>> getMarketDetails(
      int marketId) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.marketDetailsPath}marketId=$marketId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MarketDetailsResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MarketResponse>> getMarketsByFieldId(
      {fieldId, addressId, page}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getMarketsByFieldId}fieldId=$fieldId&addressId=$addressId&page=$page',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      return ApiResult.success(MarketResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<List<MarketModel>>> searchMarkets(
      {textSearch, addressId}) async {
    var data = FormData.fromMap(
        {"textSearch": textSearch, "addressId": addressId.toString()});

    var response = await DioFactory.dio!.request(
      ApiConstants.searchMarketsPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(List.from(
          (response.data as List).map((e) => MarketModel.fromJson(e))));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MarketModel>> addMarket(
      AddMarketBodyRequest addMarketBodyRequest) async {
    var data = FormData.fromMap(addMarketBodyRequest.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addMarketsPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MarketModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<List<FieldModel>>> getFields() async {
    var response = await DioFactory.dio!.request(
      ApiConstants.getFieldsPath,
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(List.from(
          (response.data as List).map((e) => FieldModel.fromJson(e))));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MarketModel>> updateMarket(
      UpdateMarketModel updateMarketModel) async {
    var data = FormData.fromMap(updateMarketModel.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.updateMarketsPath,
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MarketModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MarketResponse>> filtersMarkets(
      FilterBodyRequest filterBodyRequest) async {
   var data = FormData.fromMap(filterBodyRequest.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.filtersMarket,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MarketResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
