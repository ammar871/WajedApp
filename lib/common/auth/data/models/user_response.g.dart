// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      role: json['role'] as String,
      deviceToken: json['deviceToken'] as String?,
      status: json['status'] as String,
      code: json['code'] as String,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
      birth: json['birth'] as String?,
      points: json['points'],
      surveysBalance: json['surveysBalance'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'role': instance.role,
      'deviceToken': instance.deviceToken,
      'status': instance.status,
      'code': instance.code,
      'gender': instance.gender,
      'city': instance.city,
      'birth': instance.birth,
      'points': instance.points,
      'surveysBalance': instance.surveysBalance,
      'createdAt': instance.createdAt,
    };
