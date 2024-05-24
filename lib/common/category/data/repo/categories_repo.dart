import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/category/data/models/add_category_body_request.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/category/data/models/update_category_body.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class CategoryBase {
  Future<ApiResult<List<CategoryModel>>> getCategoriesMarket(int marketId);
  Future<ApiResult<CategoryModel>> addCategory(
      AddCategoryBodyRequest addCategoryBodyRequest);

  Future<ApiResult<CategoryModel>> updateCategory(
      UpdateCategoryBody updateCategoryBody);

  Future<ApiResult<CategoryModel>> deleteCategory(int categoryId);
}

class CategoryRepo implements CategoryBase {
  /// * add category
  @override
  Future<ApiResult<CategoryModel>> addCategory(
      AddCategoryBodyRequest addCategoryBodyRequest) async {
    var data = FormData.fromMap(addCategoryBodyRequest.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addCategoryPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CategoryModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<CategoryModel>> updateCategory(
      UpdateCategoryBody updateCategoryBody) async {
    var data = FormData.fromMap(
      updateCategoryBody.toJson(),
    );

    var response = await DioFactory.dio!.request(
      ApiConstants.updateCategoryPath,
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CategoryModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<CategoryModel>> deleteCategory(int categoryId) async {
    var data = FormData.fromMap(
      {"categoryId": categoryId.toString()},
    );

    var response = await DioFactory.dio!.request(
      ApiConstants.deleteCategoryPath,
      options: Options(
        method: 'POst',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(CategoryModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<List<CategoryModel>>> getCategoriesMarket(
      int marketId) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getCategoriesPath}marketId=${marketId}',
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(List.from(
          (response.data as List).map((e) => CategoryModel.fromJson(e))));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
