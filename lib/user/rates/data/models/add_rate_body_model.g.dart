// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_rate_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRateBodyModel _$AddRateBodyModelFromJson(Map<String, dynamic> json) =>
    AddRateBodyModel(
      typeId: json['typeId'] as int,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      type: json['type'] as String,
      stare: json['stare'] as int,
    );

Map<String, dynamic> _$AddRateBodyModelToJson(AddRateBodyModel instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'userId': instance.userId,
      'comment': instance.comment,
      'type': instance.type,
      'stare': instance.stare,
    };
