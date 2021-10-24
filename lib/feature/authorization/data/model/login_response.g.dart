// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    jwtToken: json['jwtToken'] as String,
    user: UserRemote.fromJson(json['user'] as Map<String, dynamic>),
  );
}
