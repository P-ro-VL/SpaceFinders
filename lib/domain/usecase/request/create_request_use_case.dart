import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/request_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/request_entity.dart';

class CreateRequestUseCase
    extends UseCase<Either<FailureEntity, RequestEntity>, CreateRequestParams> {
  final RequestRepository repository;

  CreateRequestUseCase(this.repository);

  @override
  Future<Either<FailureEntity, RequestEntity>> call(
      CreateRequestParams params) async {
    return await repository.createRequest(params);
  }
}

class CreateRequestParams {
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

  CreateRequestParams({
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

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'lead_id': leadId,
      'request_type': requestType,
      'request_details': requestDetails,
      'status': status,
      'reviewed_by': reviewedBy,
      'review_note': reviewNote,
      'evidence_file': evidenceFile,
    };
  }
}
