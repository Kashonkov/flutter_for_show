import 'package:json_annotation/json_annotation.dart';

part 'sms_confirm_request.g.dart';

@JsonSerializable(createFactory: false)
class SmsConfirmRequest {
  final String login;
  final String confirmToken;

  SmsConfirmRequest({
    required this.login,
    required this.confirmToken,
  });

  Map<String, dynamic> toJson() => _$SmsConfirmRequestToJson(this);
}
