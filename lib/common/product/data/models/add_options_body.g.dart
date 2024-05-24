// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_options_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOptionsBody _$AddOptionsBodyFromJson(Map<String, dynamic> json) =>
    AddOptionsBody(
      groupOptions: GroupOptionsModel.fromJson(
          json['groupOptions'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddOptionsBodyToJson(AddOptionsBody instance) =>
    <String, dynamic>{
      'groupOptions': instance.groupOptions,
      'options': instance.options,
    };
