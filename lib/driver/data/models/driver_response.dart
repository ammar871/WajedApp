import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/driver/data/models/driver_model.dart';




part 'driver_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class DriverResponse {
  final UserModel? user;
  final DriverModel? driver;

  DriverResponse({required this.user, required this.driver});



  Map<String, dynamic> toJson() => _$DriverResponseToJson(this);

  factory DriverResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverResponseFromJson(json);


}
