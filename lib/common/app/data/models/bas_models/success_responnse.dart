import 'package:json_annotation/json_annotation.dart';

part 'success_responnse.g.dart';

//dart run build_runner build
@JsonSerializable()
class SuccessResponse {
  final bool status;
  final String message;

  SuccessResponse({required this.status, required this.message});

   
   factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);
}
