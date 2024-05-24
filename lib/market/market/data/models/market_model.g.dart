// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketModel _$MarketModelFromJson(Map<String, dynamic> json) => MarketModel(
      json['id'] as int,
      json['fieldId'] as int,
      json['orderCount'] as int,
      json['titleAr'] as String,
      json['descAr'] as String,
      json['titleEng'] as String,
      json['descEng'] as String,
      json['userId'] as String,
      json['nameOwner'] as String,
      json['password'] as String,
      json['addressName'] as String,
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      (json['rate'] as num).toDouble(),
      json['status'] as int,
      (json['discount'] as num).toDouble(),
      (json['distance'] as num).toDouble(),
      json['createdAt'] as String,
      json['imageLogo'] as String,
      json['imageCommercial'] as String,
      json['minimum'],
      json['dlivaryCost'],
      json['timeDelvary'] as String,
    );

Map<String, dynamic> _$MarketModelToJson(MarketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fieldId': instance.fieldId,
      'titleAr': instance.titleAr,
      'descAr': instance.descAr,
      'titleEng': instance.titleEng,
      'descEng': instance.descEng,
      'userId': instance.userId,
      'nameOwner': instance.nameOwner,
      'password': instance.password,
      'imageLogo': instance.imageLogo,
      'imageCommercial': instance.imageCommercial,
      'addressName': instance.addressName,
      'minimum': instance.minimum,
      'dlivaryCost': instance.dlivaryCost,
      'timeDelvary': instance.timeDelvary,
      'lat': instance.lat,
      'lng': instance.lng,
      'rate': instance.rate,
      'status': instance.status,
      'discount': instance.discount,
      'distance': instance.distance,
      'orderCount': instance.orderCount,
      'createdAt': instance.createdAt,
    };
