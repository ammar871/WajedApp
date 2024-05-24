// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReqeustBody _$LoginReqeustBodyFromJson(Map<String, dynamic> json) =>
    LoginReqeustBody(
      username: json['username'] as String,
      deviceToken: json['deviceToken'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$LoginReqeustBodyToJson(LoginReqeustBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'deviceToken': instance.deviceToken,
      'code': instance.code,
    };
