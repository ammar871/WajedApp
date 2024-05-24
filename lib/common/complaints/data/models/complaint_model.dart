import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class ComplaintModel {
  final int id;
  final String email;
  final String subject;
  final String message;
  final int status;
  final String createAt;

  ComplaintModel(
      {required this.id,
      required this.email,
      required this.subject,
      required this.message,
      required this.status,
      required this.createAt});


      factory ComplaintModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintModelToJson(this);
}
