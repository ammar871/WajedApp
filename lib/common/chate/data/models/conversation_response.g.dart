// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationResponse _$ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationResponse(
      conversation: ConversationModel.fromJson(
          json['conversation'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      otherUser: UserModel.fromJson(json['otherUser'] as Map<String, dynamic>),
      lastMessage:
          MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationResponseToJson(
        ConversationResponse instance) =>
    <String, dynamic>{
      'conversation': instance.conversation,
      'user': instance.user,
      'otherUser': instance.otherUser,
      'lastMessage': instance.lastMessage,
    };

ConversationResponseSuccess _$ConversationResponseSuccessFromJson(
        Map<String, dynamic> json) =>
    ConversationResponseSuccess(
      status: json['status'] as bool,
      conversation: json['conversation'] == null
          ? null
          : ConversationModel.fromJson(
              json['conversation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationResponseSuccessToJson(
        ConversationResponseSuccess instance) =>
    <String, dynamic>{
      'status': instance.status,
      'conversation': instance.conversation,
    };

ConversationResponsePage _$ConversationResponsePageFromJson(
        Map<String, dynamic> json) =>
    ConversationResponsePage(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationResponsePageToJson(
        ConversationResponsePage instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
