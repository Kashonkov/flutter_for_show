import 'package:i_talent/feature/user_info/data/model/user_remote.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponse {
  final String jwtToken;
  final UserRemote user;

  LoginResponse({
    required this.jwtToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}
