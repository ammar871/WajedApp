// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintModel _$ComplaintModelFromJson(Map<String, dynamic> json) =>
    ComplaintModel(
      id: json['id'] as int,
      email: json['email'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      status: json['status'] as int,
      createAt: json['createAt'] as String,
    );

Map<String, dynamic> _$ComplaintModelToJson(ComplaintModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'subject': instance.subject,
      'message': instance.message,
      'status': instance.status,
      'createAt': instance.createAt,
    };
