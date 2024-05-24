import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wajed_app/common/product/data/models/add_options_body.dart';
import 'package:wajed_app/common/product/data/models/add_product_body.dart';
import 'package:wajed_app/common/product/data/models/group_options_model.dart';
import 'package:wajed_app/common/product/data/models/option_model.dart';

import 'package:wajed_app/common/product/data/models/product_details_response.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';
import 'package:wajed_app/common/product/data/models/productes_response.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class BaseProduct {
  Future<ApiResult<ProductsResponse>> getProductsByCategoryId(
      {categoryId, userId, page,marketId});

  Future<ApiResult<ProductDetailsResponse>> getProductDetails(
      {productId, userId});

  Future<ApiResult<ProductModel>> addProduct(AddProductBody productBody);

  Future<ApiResult<ProductModel>> updateProduct(ProductModel productModel);

  Future<ApiResult<ProductModel>> deleteProduct(int productId);
  Future<ApiResult<GroupOptionsModel>> addGroupProduct(
      AddOptionsBody optionsResponse);
}

class ProductRepo extends BaseProduct {
  @override
  Future<ApiResult<ProductsResponse>> getProductsByCategoryId(
      {categoryId, userId, page,marketId}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.productsByCategoryIdPath}categoryId=$categoryId&marketId=$marketId&userId=$userId&page=$page',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ProductsResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ApiResult<ProductDetailsResponse>> getProductDetails(
      {productId, userId}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.productDetailsPath}productId=$productId&userId=$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ProductDetailsResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ApiResult<ProductModel>> addProduct(AddProductBody productBody) async {
    var data = FormData.fromMap(productBody.toJson());
    var response = await DioFactory.dio!.request(
      ApiConstants.addProductPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ProductModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ApiResult<GroupOptionsModel>> addGroupProduct(
      AddOptionsBody optionsResponse) async {
    var data = FormData.fromMap(optionsResponse.groupOptions.toJson());
    var response = await DioFactory.dio!.request(
      ApiConstants.addGroupsProductPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      GroupOptionsModel groupOptionsModel =
          GroupOptionsModel.fromJson(response.data);

      /// * add options
      for (var option in optionsResponse.options) {
        option.groupId = groupOptionsModel.id;
        await addOptionsProduct(option);
      }

      return ApiResult.success(groupOptionsModel);
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }

  Future addOptionsProduct(OptionModel optionModel) async {
    var data = FormData.fromMap(optionModel.toJson());
    var response = await DioFactory.dio!.request(
      ApiConstants.addOptionsProductPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      /// * add options

      debugPrint("response added");
    } else {
      debugPrint("response fieald");
    }
  }

  @override
  Future<ApiResult<ProductModel>> deleteProduct(int productId)async {
     var data =
        FormData.fromMap({"productId": productId.toString()});

    var response = await DioFactory.dio!.request(
      ApiConstants.deleteProductPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ProductModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ApiResult<ProductModel>> updateProduct(
      ProductModel productModel) async {
    var data = FormData.fromMap(
      productModel.toJson(),
    );

    var response = await DioFactory.dio!.request(
      ApiConstants.updateProductPath,
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ProductModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: "حدث خطأ, حاول مرة أخرى");
    }
  }
}
