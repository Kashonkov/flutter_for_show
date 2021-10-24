import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordRequest {
  final String confirmToken;
  final String login;
  final String password;

  ChangePasswordRequest({
    required this.confirmToken,
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
