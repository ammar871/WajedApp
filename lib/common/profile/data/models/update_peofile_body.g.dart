// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_peofile_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileBody _$UpdateProfileBodyFromJson(Map<String, dynamic> json) =>
    UpdateProfileBody(
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$UpdateProfileBodyToJson(UpdateProfileBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'city': instance.city,
    };
