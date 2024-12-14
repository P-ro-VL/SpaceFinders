import 'package:spacefinder/data/model/request_model.dart';
import 'package:spacefinder/domain/usecase/request/create_request_use_case.dart';
import 'package:spacefinder/domain/usecase/request/update_request_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecase/request/get_all_requests_use_case.dart';

abstract class RequestDataSource {
  Future<RequestModel?> createRequest(CreateRequestParams params);

  Future<List<RequestModel>?> getAllRequests(GetAllRequestsParams params);

  Future<void> updateRequest(UpdateRequestParams params);
}

class RequestDataSourceImpl extends RequestDataSource {
  final client = Supabase.instance.client;

  @override
  Future<RequestModel?> createRequest(CreateRequestParams params) async {
    final response =
        await client.from('requests').insert(params.toJson()).select();
    if (response.firstOrNull == null) return null;
    return RequestModel.fromJson(response.first);
  }

  @override
  Future<List<RequestModel>?> getAllRequests(params) async {
    PostgrestFilterBuilder builder = client.from('requests').select();

    if (params.requestStatus != null) {
      builder = builder.eq('status', params.requestStatus!);
    }

    if (params.requestType != null) {
      builder = builder.eq('request_type', params.requestType!);
    }

    if ((params.code ?? '').trim().isNotEmpty) {
      builder =
          builder.like('code', '%${(params.code ?? '').trim().toUpperCase()}%');
    }

    final result = await builder.select().order('updated_at', ascending: false);
    if (result.isEmpty) return [];
    return result.map((map) => RequestModel.fromJson(map)).toList();
  }

  @override
  Future<void> updateRequest(UpdateRequestParams params) async {
    await client
        .from('requests')
        .update(params.toJson())
        .eq('request_id', params.requestId ?? -1);
  }
}
