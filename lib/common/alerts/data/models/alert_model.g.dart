// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) => AlertModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      titleAr: json['titleAr'] as String,
      titleEng: json['titleEng'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      page: json['page'] as String?,
      type: json['type'] as String,
      pageId: json['pageId'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'titleAr': instance.titleAr,
      'titleEng': instance.titleEng,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'page': instance.page,
      'type': instance.type,
      'pageId': instance.pageId,
      'createdAt': instance.createdAt,
    };
