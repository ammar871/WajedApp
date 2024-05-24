import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_cart_body_request.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddCartBodyRequest {
  final int quantity;

  final int cost;
  final String userId;
  final int productId;
  final String? optionsIds;
  final String? nots;

  AddCartBodyRequest(
      {required this.quantity,
      required this.cost, required this.nots,
      required this.userId,
      required this.productId,
      required this.optionsIds});

  factory AddCartBodyRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCartBodyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCartBodyRequestToJson(this);
}
