// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_by_phone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginByPhoneRequestToJson(LoginByPhoneRequest instance) {
  final val = <String, dynamic>{
    'login': instance.login,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fcmToken', instance.fcmToken);
  return val;
}
