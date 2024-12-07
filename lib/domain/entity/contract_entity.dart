class ContractEntity {
  final num? contractId;
  final num? saleId;
  final num? leadId;
  final num? rentalPrice;
  final num? depositAmount;
  final num? startDate;
  final num? endDate;
  final num? signDate;
  final String? status;
  final num? createdAt;
  final num? updatedAt;
  final String? code;
  final String? url;

  String? agentName;
  String? rentalType;
  num? commission;
  String? propertyType;

  ContractEntity({
    this.contractId,
    this.saleId,
    this.leadId,
    this.rentalPrice,
    this.depositAmount,
    this.startDate,
    this.endDate,
    this.signDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.url,
  });
}
