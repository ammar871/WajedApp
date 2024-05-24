// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as int,
      userOne: json['userOne'] as String,
      userTwo: json['userTwo'] as String,
      status: json['status'] as int,
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userOne': instance.userOne,
      'userTwo': instance.userTwo,
      'status': instance.status,
      'createAt': instance.createAt.toIso8601String(),
    };
