import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/request_data_source.dart';
import 'package:spacefinder/data/model/request_model.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';
import 'package:spacefinder/domain/repository/request_repository.dart';
import 'package:spacefinder/domain/usecase/request/create_request_use_case.dart';
import 'package:spacefinder/domain/usecase/request/get_all_requests_use_case.dart';
import 'package:spacefinder/domain/usecase/request/update_request_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource dataSource;

  RequestRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, RequestEntity>> createRequest(
      CreateRequestParams params) async {
    final response = await dataSource.createRequest(params);
    return Either.cond(response != null, FailureEntity(), response!.toEntity);
  }

  @override
  Future<Either<FailureEntity, List<RequestEntity>>> getAllRequests(
      GetAllRequestsParams params) async {
    final response = await dataSource.getAllRequests(params);
    return Either.cond(response != null, FailureEntity(),
        response!.map((model) => model.toEntity).toList());
  }

  @override
  Future<void> updateRequest(UpdateRequestParams params) async {
    await dataSource.updateRequest(params);
  }
}
