import 'package:json_annotation/json_annotation.dart';

part 'update_peofile_body.g.dart';
//dart run build_runner build
@JsonSerializable()
class UpdateProfileBody {
  final String userId;
  final String fullName;
  final String email;
  final String profileImage;
  final String city;

  UpdateProfileBody(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.profileImage,
      required this.city});


      // To json

  Map<String, dynamic> toJson() => _$UpdateProfileBodyToJson(this);
}
