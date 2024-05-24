// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) => DriverModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      addressName: json['addressName'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      profilleImage: json['profilleImage'] as String,
      imageId: json['imageId'] as String,
      imageCar: json['imageCar'] as String,
      status: json['status'] as int,
      area: json['area'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'addressName': instance.addressName,
      'lat': instance.lat,
      'lng': instance.lng,
      'profilleImage': instance.profilleImage,
      'imageId': instance.imageId,
      'imageCar': instance.imageCar,
      'status': instance.status,
      'area': instance.area,
      'createAte': instance.createAte,
    };
