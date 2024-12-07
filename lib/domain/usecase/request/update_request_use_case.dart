import 'package:spacefinder/domain/repository/request_repository.dart';
import 'package:spacefinder/network/use_case.dart';

class UpdateRequestUseCase extends UseCase<void, UpdateRequestParams> {
  final RequestRepository repository;

  UpdateRequestUseCase(this.repository);

  @override
  Future<void> call(UpdateRequestParams params) async {
    await repository.updateRequest(params);
  }
}

class UpdateRequestParams {
  final String? status;
  final num? requestId;
  final String? reviewNote;
  final num? reviewedBy;
  final String? requestType;
  final String? requestDescription;

  UpdateRequestParams({
    this.status,
    this.requestId,
    this.reviewNote,
    this.reviewedBy,
    this.requestType,
    this.requestDescription,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (status != null) {
      map['status'] = status;
    }
    if (requestId != null) {
      map['request_id'] = requestId;
    }
    if (reviewNote != null) {
      map['review_note'] = reviewNote;
    }
    if (reviewedBy != null) {
      map['reviewed_by'] = reviewedBy;
    }
    return map;
  }
}
