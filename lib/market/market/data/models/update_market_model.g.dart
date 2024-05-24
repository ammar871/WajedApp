// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMarketModel _$UpdateMarketModelFromJson(Map<String, dynamic> json) =>
    UpdateMarketModel(
      marketId: json['marketId'] as int,
      fieldId: json['fieldId'] as int,
      titleAr: json['titleAr'] as String,
      titleEng: json['titleEng'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      imageLogo: json['imageLogo'] as String,
      imageCommercial: json['imageCommercial'] as String,
      addressName: json['addressName'] as String,
      nameOwner: json['nameOwner'] as String,
      password: json['password'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$UpdateMarketModelToJson(UpdateMarketModel instance) =>
    <String, dynamic>{
      'marketId': instance.marketId,
      'fieldId': instance.fieldId,
      'titleAr': instance.titleAr,
      'titleEng': instance.titleEng,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'imageLogo': instance.imageLogo,
      'imageCommercial': instance.imageCommercial,
      'addressName': instance.addressName,
      'nameOwner': instance.nameOwner,
      'password': instance.password,
      'lat': instance.lat,
      'lng': instance.lng,
    };
