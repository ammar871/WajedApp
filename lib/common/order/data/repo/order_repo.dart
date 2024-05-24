import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/order/data/models/order_response.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../models/add_order_body.dart';
import '../models/order_details_response.dart';
import '../models/order_model.dart';
import '../models/orders_market_response.dart';

abstract class BaseOrder {
  Future<ApiResult<OrderResponse>> getOrders(String userId,int page,int status);
  Future<ApiResult<OrdersMarketResponse>> getOrdersByMarketId({marketId, page});

  Future<ApiResult<OrderDriverResponse>> getOrdersByDriverId({driverId, page});
  Future<ApiResult<OrderDetailsResponse>> getOrderDetails(int orderId);
  Future<ApiResult<OrderModel>> addOrder(AddOrderBody body);
  Future<ApiResult<OrderModel>> reOrder(int orderId);
  Future<ApiResult<OrderModel>> deleteOrder(int orderId);
  Future<ApiResult<OrderModel>> updateOrderStatus({orderId, status});

  Future<ApiResult<OrderModel>> acceptOrderDriver({orderId, driverId});
}

class OrdersRepo implements BaseOrder {
  @override
  Future<ApiResult<OrderResponse>> getOrders(String userId,int page,int status) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getOrdersPath}UserId=$userId&"page=$page&status=$status',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      return ApiResult.success( OrderResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderModel>> addOrder(AddOrderBody addOrderBody) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var data = FormData.fromMap(addOrderBody.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addOrderPath,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderModel>> reOrder(int orderId) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var data = FormData.fromMap({'OrderId': orderId.toString()});

    var response = await DioFactory.dio!.request(
      ApiConstants.reAddOrderPath,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderModel>> updateOrderStatus({orderId, status}) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};

    var data = FormData.fromMap({
      'orderId': orderId.toString(),
      'status': status.toString(),
      "role": AppModel.currentRole
    });
    var response = await DioFactory.dio!.request(
      ApiConstants.updateStatusOrderPath,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderModel>> deleteOrder(int orderId) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};

    var data = FormData.fromMap({'orderId': orderId.toString()});
    var response = await DioFactory.dio!.request(
      ApiConstants.deleteOrderPath,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderDetailsResponse>> getOrderDetails(int orderId) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getOrderDetailsPath}orderId=$orderId',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderDetailsResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrdersMarketResponse>> getOrdersByMarketId(
      {marketId, page}) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getOrdersByMarketIdPath}marketId=$marketId&page=$page',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrdersMarketResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderModel>> acceptOrderDriver({orderId, driverId}) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};

    var data = FormData.fromMap(
        {'orderId': orderId.toString(), 'driverId': driverId.toString()});
    var response = await DioFactory.dio!.request(
      ApiConstants.acceptOrderDriverPath,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<OrderDriverResponse>> getOrdersByDriverId(
      {driverId, page}) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getOrdersByDriverIdPath}driverId=$driverId&page=$page',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(OrderDriverResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
