import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(createToJson: false)
class BaseResponse{
  // final Map<String, dynamic> object;
  final Object object;
  final String operationInfo;
  final String? operationResult;

  BaseResponse(this.object, this.operationInfo, this.operationResult);

  factory  BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
}
