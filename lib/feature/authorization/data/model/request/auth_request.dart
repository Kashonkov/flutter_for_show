import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable(createFactory: false)
class AuthRequest {
  final String? fcmToken;
  final String login;
  final String password;

  AuthRequest({
    this.fcmToken,
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
