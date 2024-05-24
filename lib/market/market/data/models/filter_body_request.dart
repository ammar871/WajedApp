import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_body_request.g.dart';

//dart run build_runner build
@JsonSerializable()
class  FilterBodyRequest {
  /// * => 0 no filter \ 1 = filter
  final int? byRate;
  final int? byMostOrders;
  final int? fieldId;
  final int page;
  final String userId;

  FilterBodyRequest({this.byRate, this.byMostOrders, this.fieldId, required this.page, required this.userId});

  // * to json
  Map<String, dynamic> toJson() => _$FilterBodyRequestToJson(this);




}