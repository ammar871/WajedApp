
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'signup_request_body.g.dart';
@JsonSerializable()
class SignUpRequestBody {
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final String role;
  final String city;

  SignUpRequestBody({required this.fullName, required this.userName, required this.email, required this.password, required this.role, required this.city});




 Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
