import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';
import 'package:spacefinder/domain/usecase/request/create_request_use_case.dart';
import 'package:spacefinder/domain/usecase/request/get_all_requests_use_case.dart';
import 'package:spacefinder/domain/usecase/request/update_request_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

abstract class RequestRepository {
  Future<Either<FailureEntity, RequestEntity>> createRequest(
      CreateRequestParams params);

  Future<Either<FailureEntity, List<RequestEntity>>> getAllRequests(
      GetAllRequestsParams params);

  Future<void> updateRequest(UpdateRequestParams params);
}
