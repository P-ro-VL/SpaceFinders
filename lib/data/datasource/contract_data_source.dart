import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/contract_model.dart';

abstract class ContractDataSource {
  Future<List<ContractModel>?> getAllContracts();

  Future<ContractModel?> createContract(CreateContractParams params);
}

class ContractDataSourceImpl extends ContractDataSource {
  final client = Supabase.instance.client;

  @override
  Future<List<ContractModel>?> getAllContracts() async {
    final response = await client.from('contracts').select();
    return response.map((e) => ContractModel.fromJson(e)).toList();
  }

  @override
  Future<ContractModel?> createContract(CreateContractParams params) async {
    final response =
        await client.from('contracts').insert(params.toJson()).select();
    if (response.firstOrNull == null) return null;
    return ContractModel.fromJson(response.first);
  }
}
