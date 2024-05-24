import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:wajed_app/common/chate/data/models/conversation_response.dart';
import 'package:wajed_app/common/chate/data/models/message_model.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/strings.dart';
import '../models/messages_response.dart';

abstract class BaseChate {
  Future<ApiResult<MessageModel>> sendMessage(MessageModel message);
  Future<ApiResult<ConversationResponseSuccess>> getConvByUserId({userOne, userTwo});
  Future<ApiResult<ConversationResponsePage>> getConvsByUserId(
      {userId,page});
  Future<ApiResult<MessagesResponse>> getMessagesByUserId(
      {userOne, userTwo, page});
  Future<ApiResult<MessagesResponse>> getMessagesByConversationId(
      {convId, page});
}

class ChateRepo extends BaseChate {
  @override
  Future<ApiResult<ConversationResponseSuccess>> getConvByUserId(
      {userOne, userTwo}) async {
    // * implement getConvByUserId
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getConvByUserIdPath}userOne=$userOne&userTwo=$userTwo',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ConversationResponseSuccess.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<ConversationResponsePage>> getConvsByUserId(
      {userId,page}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getConvsByUserIdPath}userId=$userId&page=$page',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ConversationResponsePage.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MessagesResponse>> getMessagesByConversationId(
      {convId, page}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getMessagesByConvIdPath}convId=$convId&page=$page',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MessagesResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MessagesResponse>> getMessagesByUserId(
      {userOne, userTwo, page}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getMessagesByUserIdPath}userOne=$userOne&userTwo=$userTwo&page=$page',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MessagesResponse.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<MessageModel>> sendMessage(MessageModel message) async {
    var data = FormData.fromMap(message.toJson());
    var response = await DioFactory.dio!.request(
      ApiConstants.sendMessagePath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(MessageModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
}
