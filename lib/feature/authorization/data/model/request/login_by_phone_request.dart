import 'package:json_annotation/json_annotation.dart';

part 'login_by_phone_request.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class LoginByPhoneRequest {
  final String login;
  final String? fcmToken;

  LoginByPhoneRequest({
    required this.login,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() => _$LoginByPhoneRequestToJson(this);
}
