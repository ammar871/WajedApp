// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoraite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavorateModel _$FavorateModelFromJson(Map<String, dynamic> json) =>
    FavorateModel(
      json['id'] as int,
      json['userId'] as String?,
      json['marketId'] as int,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$FavorateModelToJson(FavorateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'marketId': instance.marketId,
      'createdAt': instance.createdAt,
    };
