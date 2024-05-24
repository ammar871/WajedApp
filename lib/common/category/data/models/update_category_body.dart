import 'package:freezed_annotation/freezed_annotation.dart';
//dart run build_runner build
part 'update_category_body.g.dart';
@JsonSerializable()
class  UpdateCategoryBody{
  final int id;
  final String nameAr;
  final String nameEng;

  UpdateCategoryBody({required this.id, required this.nameAr, required this.nameEng});

  /// to json
  Map<String, dynamic> toJson() => _$UpdateCategoryBodyToJson(this);

}