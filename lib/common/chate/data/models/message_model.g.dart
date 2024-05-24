// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as int,
      convId: json['convId'] as int,
      type: json['type'] as int,
      text: json['text'] as String?,
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      status: json['status'] as int,
      isReading: json['isReading'] as bool,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'convId': instance.convId,
      'type': instance.type,
      'text': instance.text,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'status': instance.status,
      'isReading': instance.isReading,
      'createdAt': instance.createdAt,
    };
