import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
class ContractModel with _$ContractModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory ContractModel({
    final num? contractId,
    num? salesId,
    num? leadId,
    num? rentalPrice,
    num? depositAmount,
    num? startDate,
    num? endDate,
    num? signDate,
    String? status,
    num? createdAt,
    num? updatedAt,
    String? code,
    String? url,
  }) = _ContractModel;

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);
}

extension ContractModelExts on ContractModel {
  ContractEntity get toEntity => ContractEntity(
        contractId: contractId,
        saleId: salesId,
        leadId: leadId,
        rentalPrice: rentalPrice,
        depositAmount: depositAmount,
        startDate: startDate,
        endDate: endDate,
        signDate: signDate,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
        code: code,
        url: url,
      );
}
