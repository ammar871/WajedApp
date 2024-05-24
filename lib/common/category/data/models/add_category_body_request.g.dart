// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_category_body_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCategoryBodyRequest _$AddCategoryBodyRequestFromJson(
        Map<String, dynamic> json) =>
    AddCategoryBodyRequest(
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      marketId: json['marketId'] as int,
    );

Map<String, dynamic> _$AddCategoryBodyRequestToJson(
        AddCategoryBodyRequest instance) =>
    <String, dynamic>{
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'marketId': instance.marketId,
    };
