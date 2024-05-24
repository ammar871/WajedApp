import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class BaseApp {
  Future<ApiResult<String>> uploadIamage(File file);
  Future<ApiResult<bool>> updateDeviceToken({userId, token});
  Future<ApiResult<File>> getImagePicker();
}

class AppRepo implements BaseApp {
  @override
  Future<ApiResult<String>> uploadIamage(File file) async {
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    final response =
        await Dio().post(ApiConstants.uploadImagesPath, data: data);

    if (response.statusCode == 200) {
      return ApiResult.success(response.data);
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<bool>> updateDeviceToken({userId, token}) async {
    var data = FormData.fromMap({"userId": userId, "Token": token});
    var response = await DioFactory.dio!.request(
      ApiConstants.updateDeviceTokenPath,
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      debugPrint("device token updated ");
      return ApiResult.success(response.data);
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<File>> getImagePicker() async {
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (pickedFile != null) {
      return ApiResult.success(File(pickedFile.path));
    } else {
      return ApiResult.failure(
          statusCode: "404", message: Strings.someError.tr());
    }
  }
}
