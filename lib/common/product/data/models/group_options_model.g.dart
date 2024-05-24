// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupOptionsModel _$GroupOptionsModelFromJson(Map<String, dynamic> json) =>
    GroupOptionsModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      productId: json['productId'] as int,
    );

Map<String, dynamic> _$GroupOptionsModelToJson(GroupOptionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'productId': instance.productId,
    };
