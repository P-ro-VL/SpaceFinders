import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';

import '../../network/failure_entity.dart';

abstract class ContractRepository {
  Future<Either<FailureEntity, List<ContractEntity>>> getAllContracts();

  Future<Either<FailureEntity, ContractEntity>> createContract(
      CreateContractParams params);
}
