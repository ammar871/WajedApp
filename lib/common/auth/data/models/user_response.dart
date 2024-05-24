import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_response.g.dart';
//dart run build_runner build
@JsonSerializable()
class UserResponse {
  final String token;
  final UserModel user;
  UserResponse({required this.token, required this.user});
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
@JsonSerializable()
class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String? profileImage;
  final String role;
  final String? deviceToken;
  final String status;
  final String code;
  final String? gender;
  final String? city;
  final String? birth;
  final dynamic points;
  final String? surveysBalance;
  final String? createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.deviceToken,
    required this.status,
    required this.code,
    required this.gender,
    required this.city,
    required this.birth,
    required this.points,
    required this.surveysBalance,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
