import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddressModel {
  final int id;
  final String userId;
  final String description;
  final String name;
  final double lat;
  final double lng;
  final bool defaultAddress;
  final String createdAt;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.name,
    required this.lat,
    required this.lng,
    required this.defaultAddress,
    required this.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
