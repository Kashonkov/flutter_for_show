import 'package:json_annotation/json_annotation.dart';

part 'repeat_sms_request.g.dart';

@JsonSerializable(createFactory: false)
class RepeatSmsRequest {
  final String login;

  RepeatSmsRequest({
    required this.login,
  });

  Map<String, dynamic> toJson() => _$RepeatSmsRequestToJson(this);
}
