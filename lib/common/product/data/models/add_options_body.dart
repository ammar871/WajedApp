import 'package:wajed_app/common/product/data/models/group_options_model.dart';

import 'option_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_options_body.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddOptionsBody{
   final GroupOptionsModel groupOptions;
   final List<OptionModel> options;

   AddOptionsBody({required this.groupOptions,required this.options});

  Map<String, dynamic> toJson() => _$AddOptionsBodyToJson(this);

  factory AddOptionsBody.fromJson(Map<String, dynamic> json) =>
      _$AddOptionsBodyFromJson(json);
 
        
}