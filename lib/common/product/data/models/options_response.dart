import 'package:freezed_annotation/freezed_annotation.dart';

import 'group_options_model.dart';
import 'option_model.dart';


part 'options_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class OptionsResponse {
  final GroupOptionsModel group;
  List<OptionModel> productsOptions1;

  OptionsResponse({
    required this.group,
    required this.productsOptions1,
  });



  factory OptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsResponseToJson(this);
}
