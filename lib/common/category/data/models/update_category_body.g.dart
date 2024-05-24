// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_category_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCategoryBody _$UpdateCategoryBodyFromJson(Map<String, dynamic> json) =>
    UpdateCategoryBody(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
    );

Map<String, dynamic> _$UpdateCategoryBodyToJson(UpdateCategoryBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
    };
