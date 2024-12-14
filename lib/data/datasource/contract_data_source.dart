import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';
import 'package:spacefinder/domain/usecase/contract/get_all_contracts_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/contract_model.dart';

abstract class ContractDataSource {
  Future<List<ContractModel>?> getAllContracts(GetAllContractsParams params);

  Future<ContractModel?> createContract(CreateContractParams params);
}

class ContractDataSourceImpl extends ContractDataSource {
  final client = Supabase.instance.client;

  @override
  Future<List<ContractModel>?> getAllContracts(
      GetAllContractsParams params) async {
    PostgrestFilterBuilder response = client.from('contracts').select();

    if ((params.keyword ?? '').trim().isNotEmpty) {
      response = response.like(
          'code', '%${(params.keyword ?? '').trim().toUpperCase()}%');
    }

    final res = response.order('updated_at', ascending: false);
    return (await res)
        .map((e) => ContractModel.fromJson(e))
        .toList()
        .cast<ContractModel>();
  }

  @override
  Future<ContractModel?> createContract(CreateContractParams params) async {
    final response =
        await client.from('contracts').insert(params.toJson()).select();
    if (response.firstOrNull == null) return null;
    return ContractModel.fromJson(response.first);
  }
}
