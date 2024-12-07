// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractModelImpl _$$ContractModelImplFromJson(Map<String, dynamic> json) =>
    _$ContractModelImpl(
      contractId: json['contract_id'] as num?,
      salesId: json['sales_id'] as num?,
      leadId: json['lead_id'] as num?,
      rentalPrice: json['rental_price'] as num?,
      depositAmount: json['deposit_amount'] as num?,
      startDate: json['start_date'] as num?,
      endDate: json['end_date'] as num?,
      signDate: json['sign_date'] as num?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as num?,
      updatedAt: json['updated_at'] as num?,
      code: json['code'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ContractModelImplToJson(_$ContractModelImpl instance) =>
    <String, dynamic>{
      'contract_id': instance.contractId,
      'sales_id': instance.salesId,
      'lead_id': instance.leadId,
      'rental_price': instance.rentalPrice,
      'deposit_amount': instance.depositAmount,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'sign_date': instance.signDate,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'code': instance.code,
      'url': instance.url,
    };
