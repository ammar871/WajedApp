// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_market_body_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMarketBodyRequest _$AddMarketBodyRequestFromJson(
        Map<String, dynamic> json) =>
    AddMarketBodyRequest(
      fieldId: json['fieldId'] as int,
      titleAr: json['titleAr'] as String,
      titleEng: json['titleEng'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      userId: json['userId'] as String,
      nameOwner: json['nameOwner'] as String,
      imageLogo: json['imageLogo'] as String,
      password: json['password'] as String,
      imageCommercial: json['imageCommercial'] as String,
      addressName: json['addressName'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$AddMarketBodyRequestToJson(
        AddMarketBodyRequest instance) =>
    <String, dynamic>{
      'fieldId': instance.fieldId,
      'titleAr': instance.titleAr,
      'titleEng': instance.titleEng,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'userId': instance.userId,
      'imageLogo': instance.imageLogo,
      'imageCommercial': instance.imageCommercial,
      'addressName': instance.addressName,
      'password': instance.password,
      'nameOwner': instance.nameOwner,
      'lat': instance.lat,
      'lng': instance.lng,
    };
