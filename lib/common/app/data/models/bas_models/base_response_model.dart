import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class BaseResponseModel {
  final int totalPages;
  final int currentPage;

  BaseResponseModel({
    required this.totalPages,
    required this.currentPage,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson(json);

}
