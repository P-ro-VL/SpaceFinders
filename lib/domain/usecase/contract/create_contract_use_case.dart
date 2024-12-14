import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/domain/repository/contract_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class CreateContractUseCase extends UseCase<
    Either<FailureEntity, ContractEntity>, CreateContractParams> {
  final ContractRepository repository;

  CreateContractUseCase(this.repository);

  @override
  Future<Either<FailureEntity, ContractEntity>> call(
      CreateContractParams params) async {
    return await repository.createContract(params);
  }
}

class CreateContractParams {
  final num? salesId;
  final num? leadId;
  final String? propertyCode;
  final num? price;
  final String? status;
  final num? depositAmount;
  final num? signedDate;
  final num? startDate;
  final num? endDate;
  final String? url;

  CreateContractParams(
      {this.salesId,
      this.leadId,
      this.propertyCode,
      this.price,
      this.status,
      this.depositAmount,
      this.signedDate,
      this.startDate,
      this.endDate,
      this.url});

  Map<String, dynamic> toJson() {
    return {
      'sales_id': salesId,
      'code': propertyCode,
      'rental_price': price,
      'lead_id': leadId,
      'deposit_amount': depositAmount,
      'status': status,
      'sign_date': signedDate,
      'start_date': startDate,
      'end_date': endDate,
      'url': url,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
