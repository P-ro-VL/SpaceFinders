import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/contract_data_source.dart';
import 'package:spacefinder/data/model/contract_model.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/domain/repository/contract_repository.dart';
import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

import '../../domain/usecase/contract/get_all_contracts_use_case.dart';

class ContractRepositoryImpl extends ContractRepository {
  final ContractDataSource dataSource;

  ContractRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, List<ContractEntity>>> getAllContracts(
      GetAllContractsParams params) async {
    final response = await dataSource.getAllContracts(params);
    return Either.cond(response != null, FailureEntity(),
        response!.map((e) => e.toEntity).toList());
  }

  @override
  Future<Either<FailureEntity, ContractEntity>> createContract(
      CreateContractParams params) async {
    final response = await dataSource.createContract(params);
    return Either.cond(response != null, FailureEntity(), response!.toEntity);
  }
}
