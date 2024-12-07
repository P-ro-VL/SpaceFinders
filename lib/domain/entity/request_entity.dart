import 'package:spacefinder/domain/entity/lead_entity.dart';

class RequestEntity {
  final num? requestId;
  final num? userId;
  final num? leadId;
  final String? requestType;
  final String? requestDetails;
  final String? status;
  final num? reviewedBy;
  final String? reviewNote;
  final String? evidenceFile;
  final num? createdAt;
  final num? updatedAt;

  LeadEntity? lead;
  String? reviewedByName;

  RequestEntity({
    this.requestId,
    this.userId,
    this.leadId,
    this.requestType,
    this.requestDetails,
    this.status,
    this.reviewedBy,
    this.reviewNote,
    this.evidenceFile,
    this.createdAt,
    this.updatedAt,
  });
}
