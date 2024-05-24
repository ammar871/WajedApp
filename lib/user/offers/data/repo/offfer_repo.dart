import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/market/market/data/models/market_response.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/strings.dart';
import '../models/offfer_model.dart';

abstract class BaseOffer {
  Future<ApiResult<List<OfferModel>>> getOffers({userId, page});
  Future<ApiResult<MarketResponse>> getMarketsByOfferId(
      {offerId, addressId, page});
}

class OffferRepo implements BaseOffer {
  @override
  Future<ApiResult<MarketResponse>> getMarketsByOfferId(
      {offerId, addressId, page}) async {
    var response = await DioFactory.dioGet(
        url:
            '${ApiConstants.getMarketsByOfferId}offerId=$offerId&addressId=$addressId&page=$page');
    if (response.statusCode == 200) {
      return ApiResult.success(MarketResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<List<OfferModel>>> getOffers({userId, page}) async {
    var response = await DioFactory.dioGet(
        url: "${ApiConstants.getOffersPath}page=$page&userId=$userId");
    if (response.statusCode == 200) {
      return ApiResult.success(
          List.from(response.data).map((e) => OfferModel.fromJson(e)).toList());
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
