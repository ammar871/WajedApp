
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_body_request.g.dart';
//dart run build_runner build
@JsonSerializable()
class AddCategoryBodyRequest {
  final String nameAr;
  final String nameEng;
  final int marketId;
  AddCategoryBodyRequest({
    required this.nameAr,
    required this.nameEng,
    required this.marketId,
  });

  factory AddCategoryBodyRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCategoryBodyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCategoryBodyRequestToJson(this);
}
