// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsResponse _$OptionsResponseFromJson(Map<String, dynamic> json) =>
    OptionsResponse(
      group: GroupOptionsModel.fromJson(json['group'] as Map<String, dynamic>),
      productsOptions1: (json['productsOptions1'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionsResponseToJson(OptionsResponse instance) =>
    <String, dynamic>{
      'group': instance.group,
      'productsOptions1': instance.productsOptions1,
    };
