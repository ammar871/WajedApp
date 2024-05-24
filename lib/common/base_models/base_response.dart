import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';
//dart run build_runner build
@JsonSerializable()
class BaseResponse {
    final int currentPage;
    final int totalPages;
    BaseResponse({required this.currentPage, required this.totalPages});

    factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
    Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
    
}