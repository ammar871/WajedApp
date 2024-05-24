import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/cart/data/models/add_cart_body_request.dart';
import 'package:wajed_app/user/cart/data/models/cart_model.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class BaseCart {
  Future<ApiResult<AddCartBodyRequest>> addCart(AddCartBodyRequest cartModel);

  Future<ApiResult<CartResponse>> getCarts(String userId, String code);

  Future<ApiResult<CartModel>> updateCart({quantity, id});

  Future<ApiResult<CartModel>> deleteCart({cartId});


}

class CartRepo implements BaseCart {
  @override
  Future<ApiResult<AddCartBodyRequest>> addCart(
      AddCartBodyRequest cartBodyRequest) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var data = FormData.fromMap(cartBodyRequest.toJson());

    var response = await DioFactory.dio!.request(
      '${ApiConstants.baseUrl}/cart/add-cart',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddCartBodyRequest.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<CartResponse>> getCarts(String userId, String code) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};
    var response = await DioFactory.dio!.request(
      '${ApiConstants.baseUrl}/cart/get-carts?UserId=${currentUser!.user.id}&Code=""',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CartResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<CartModel>> updateCart({quantity, id}) async {
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};

    var data = FormData.fromMap(
        {'Quantity': quantity.toString(), 'id': id.toString()});
    var response = await DioFactory.dio!.request(
      '${ApiConstants.baseUrl}/cart/update-cart',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CartModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
  
  @override
  Future<ApiResult<CartModel>> deleteCart({cartId}) async{
    var headers = {'Authorization': 'Bearer ${currentUser!.token}'};

    var data = FormData.fromMap(
        {'cartId': cartId.toString()});
    var response = await DioFactory.dio!.request(
      '${ApiConstants.baseUrl}/cart/delete-cart',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CartModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:  Strings.someError.tr());
    }
  }
}
