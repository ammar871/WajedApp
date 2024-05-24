import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_address_body_request.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddAddressBodyReqquest {
  final int? id;
  final String userId;
  final String description;
  final String name;
  final double lat;
  final double lng;
  final bool defaultAddress;

  AddAddressBodyReqquest(
      {required this.userId,this.id, 
      required this.description,
      required this.name,
      required this.lat,
      required this.lng,
      required this.defaultAddress});

  factory AddAddressBodyReqquest.fromJson(Map<String, dynamic> json) =>
      _$AddAddressBodyReqquestFromJson(json);
  Map<String, dynamic> toJson() => _$AddAddressBodyReqquestToJson(this);
}
