// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'] as int,
      image: json['image'] as String,
      status: json['status'] as int,
      icon: json['icon'] as String?,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'icon': instance.icon,
      'status': instance.status,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'createdAt': instance.createdAt,
    };
