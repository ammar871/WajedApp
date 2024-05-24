
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class DriverModel {
  final int id;
  final String userId;
  final String addressName;
  final double lat;
  final double lng;
  final String profilleImage;
  final String imageId;
  final String imageCar;
  final int status;
  final int area;
  final String createAte;

  DriverModel(
      {required this.id,
      required this.userId,
      required this.addressName,
      required this.lat,
      required this.lng,
      required this.profilleImage,
      required this.imageId,
      required this.imageCar,
      required this.status,
      required this.area,
      required this.createAte});

      factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
