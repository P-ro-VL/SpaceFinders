import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/request_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/request_entity.dart';

class GetAllRequestsUseCase extends UseCase<
    Either<FailureEntity, List<RequestEntity>>, GetAllRequestsParams> {
  final RequestRepository repository;

  GetAllRequestsUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<RequestEntity>>> call(
      GetAllRequestsParams params) async {
    return await repository.getAllRequests(params);
  }
}

class GetAllRequestsParams {
  final String? requestStatus;
  final String? requestType;

  GetAllRequestsParams({
    this.requestStatus,
    this.requestType,
  });
}
