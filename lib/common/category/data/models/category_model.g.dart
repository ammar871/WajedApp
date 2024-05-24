// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      marketId: json['marketId'] as int,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'marketId': instance.marketId,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
