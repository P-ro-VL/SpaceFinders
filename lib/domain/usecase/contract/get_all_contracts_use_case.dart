import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/domain/repository/contract_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetAllContractsUseCase extends UseCase<
    Either<FailureEntity, List<ContractEntity>>, GetAllContractsParams> {
  final ContractRepository repository;

  GetAllContractsUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<ContractEntity>>> call(
      GetAllContractsParams params) async {
    return await repository.getAllContracts(params);
  }
}

class GetAllContractsParams {
  final String? keyword;

  GetAllContractsParams({this.keyword});
}
