

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_driver_body.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddDriverBody {
  final String userId;
  final String addressName;
  final double lat;
  final double lng;
  final String profileImage;
  final String imageId;
  final String imageCar;

  final int area;

  AddDriverBody(
      {required this.userId,
      required this.addressName,
      required this.lat,
      required this.lng,
      required this.profileImage,
      required this.imageId,
      required this.imageCar,
      required this.area});

      // * to json

  Map<String, dynamic> toJson() => _$AddDriverBodyToJson(this);
}
