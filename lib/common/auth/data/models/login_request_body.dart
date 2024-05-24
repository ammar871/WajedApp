//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart';
@JsonSerializable()
class LoginReqeustBody{

  final String username;
  final String deviceToken;
  final String code;

  // final String role;

  LoginReqeustBody({required this.username, required this.deviceToken, required this.code});

	
  
  factory LoginReqeustBody.fromJson(Map<String, dynamic> json) =>
      _$LoginReqeustBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReqeustBodyToJson(this);


}