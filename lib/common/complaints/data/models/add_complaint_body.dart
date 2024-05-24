
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_complaint_body.g.dart';
@JsonSerializable()
class AddCopmlaintBody{
    final String email;
  final String subject;
  final String message;
  AddCopmlaintBody({
    required this.email,
    required this.subject,
    required this.message
  });
  
  factory AddCopmlaintBody.fromJson(Map<String, dynamic> json) => _$AddCopmlaintBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AddCopmlaintBodyToJson(this);


}