
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.g.dart';
//dart run build_runner build
@JsonSerializable()
class CategoryModel {
  final int id;
  final String nameAr;
  final String nameEng;
  final int marketId;
  final int status;
  final String createdAt;

  CategoryModel(
      {required this.id,
      required this.nameAr,
      required this.nameEng,
      required this.marketId,

      required this.status,
      required this.createdAt});

      factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
