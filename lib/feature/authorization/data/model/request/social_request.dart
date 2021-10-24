import 'package:json_annotation/json_annotation.dart';

part 'social_request.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class SocialRequest {
  final String userId;
  final String token;
  final String? code;

  SocialRequest({
    required this.userId,
    required this.token,
    this.code,
  });

  Map<String, dynamic> toJson() => _$SocialRequestToJson(this);
}
