import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class FieldModel {
  final int id;
  final String nameAr;
  final String nameEng;
  final String imageUrl;
  final int status;
  final String createdAt;

  FieldModel(
      {required this.id,
      required this.nameAr,
      required this.nameEng,
      required this.imageUrl,
      required this.status,
      required this.createdAt});

  factory FieldModel.fromJson(Map<String, dynamic> json) =>
      _$FieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$FieldModelToJson(this);
}
