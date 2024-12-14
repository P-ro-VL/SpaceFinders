import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';

import '../../network/failure_entity.dart';
import '../usecase/contract/get_all_contracts_use_case.dart';

abstract class ContractRepository {
  Future<Either<FailureEntity, List<ContractEntity>>> getAllContracts(
      GetAllContractsParams params);

  Future<Either<FailureEntity, ContractEntity>> createContract(
      CreateContractParams params);
}
