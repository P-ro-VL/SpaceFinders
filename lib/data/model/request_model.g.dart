// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestModelImpl _$$RequestModelImplFromJson(Map<String, dynamic> json) =>
    _$RequestModelImpl(
      requestId: json['request_id'] as num?,
      userId: json['user_id'] as num?,
      leadId: json['lead_id'] as num?,
      requestType: json['request_type'] as String?,
      requestDetails: json['request_details'] as String?,
      status: json['status'] as String?,
      reviewedBy: json['reviewed_by'] as num?,
      reviewNote: json['review_note'] as String?,
      evidenceFile: json['evidence_file'] as String?,
      createdAt: json['created_at'] as num?,
      updatedAt: json['updated_at'] as num?,
    );

Map<String, dynamic> _$$RequestModelImplToJson(_$RequestModelImpl instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'user_id': instance.userId,
      'lead_id': instance.leadId,
      'request_type': instance.requestType,
      'request_details': instance.requestDetails,
      'status': instance.status,
      'reviewed_by': instance.reviewedBy,
      'review_note': instance.reviewNote,
      'evidence_file': instance.evidenceFile,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
