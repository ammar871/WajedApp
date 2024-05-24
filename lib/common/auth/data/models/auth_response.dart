
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.g.dart';
//dart run build_runner build
@JsonSerializable()
class AuthResponse {
    final bool status;
    final String code;

    AuthResponse({required this.status, required this.code});

    factory AuthResponse.fromJson(Map<String, dynamic> json) =>
        _$AuthResponseFromJson(json);

    Map<String, dynamic> toJson() => _$AuthResponseToJson(this);


}