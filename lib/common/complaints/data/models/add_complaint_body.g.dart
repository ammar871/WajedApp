// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_complaint_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCopmlaintBody _$AddCopmlaintBodyFromJson(Map<String, dynamic> json) =>
    AddCopmlaintBody(
      email: json['email'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddCopmlaintBodyToJson(AddCopmlaintBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'subject': instance.subject,
      'message': instance.message,
    };
