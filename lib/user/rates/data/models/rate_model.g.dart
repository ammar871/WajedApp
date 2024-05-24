// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      typeId: json['typeId'] as int,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      type: json['type'] as String,
      id: json['id'] as int,
      createAte: json['createAte'] as String,
      stare: json['stare'] as int,
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'userId': instance.userId,
      'comment': instance.comment,
      'type': instance.type,
      'stare': instance.stare,
      'createAte': instance.createAte,
    };

AddRateResponse _$AddRateResponseFromJson(Map<String, dynamic> json) =>
    AddRateResponse(
      message: json['message'] as String,
      rate: RateModel.fromJson(json['rate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddRateResponseToJson(AddRateResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'rate': instance.rate,
    };
