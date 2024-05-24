// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_driver_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddDriverBody _$AddDriverBodyFromJson(Map<String, dynamic> json) =>
    AddDriverBody(
      userId: json['userId'] as String,
      addressName: json['addressName'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      profileImage: json['profileImage'] as String,
      imageId: json['imageId'] as String,
      imageCar: json['imageCar'] as String,
      area: json['area'] as int,
    );

Map<String, dynamic> _$AddDriverBodyToJson(AddDriverBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'addressName': instance.addressName,
      'lat': instance.lat,
      'lng': instance.lng,
      'profileImage': instance.profileImage,
      'imageId': instance.imageId,
      'imageCar': instance.imageCar,
      'area': instance.area,
    };
