import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
class RequestModel with _$RequestModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory RequestModel({
    num? requestId,
    num? userId,
    num? leadId,
    String? requestType,
    String? requestDetails,
    String? status,
    num? reviewedBy,
    String? reviewNote,
    String? evidenceFile,
    num? createdAt,
    num? updatedAt,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
}

extension RequestModelExts on RequestModel {
  RequestEntity get toEntity => RequestEntity(
        requestId: requestId,
        userId: userId,
        leadId: leadId,
        requestType: requestType,
        requestDetails: requestDetails,
        status: status,
        reviewedBy: reviewedBy,
        reviewNote: reviewNote,
        evidenceFile: evidenceFile,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
