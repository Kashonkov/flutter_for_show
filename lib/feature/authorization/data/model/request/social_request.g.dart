// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SocialRequestToJson(SocialRequest instance) {
  final val = <String, dynamic>{
    'userId': instance.userId,
    'token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  return val;
}
