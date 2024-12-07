import 'package:spacefinder/data/model/lead_model.dart';
import 'package:spacefinder/domain/usecase/lead/create_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_all_lead_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';
import '../../domain/usecase/lead/update_lead_use_case.dart';

abstract class LeadDataSource {
  Future<LeadModel?> getLead(num? leadId);

  Future<LeadModel?> createLead(CreateLeadParams params);

  Future<bool?> updateLead(UpdateLeadParams params);

  Future<List<LeadModel>?> getAllLeads(GetAllLeadParams params);

  Future<void> uploadLeadImages(num leadId, List<String> images);

  Future<List<String>?> getLeadImages(num leadId);
}

class LeadDataSourceImpl extends LeadDataSource {
  SupabaseClient get client => Supabase.instance.client;

  @override
  Future<LeadModel?> createLead(CreateLeadParams params) async {
    final response = await client
        .from(Constants.table_lead)
        .insert(params.toJson())
        .select();
    if (response.firstOrNull == null) return null;
    return LeadModel.fromJson(response.first);
  }

  @override
  Future<LeadModel?> getLead(num? leadId) async {
    final response = await client
        .from(Constants.table_lead)
        .select()
        .eq('lead_id', leadId ?? -1);
    if (response.firstOrNull == null) return null;
    return LeadModel.fromJson(response.first);
  }

  @override
  Future<bool?> updateLead(UpdateLeadParams params) async {
    final response = await client
        .from(Constants.table_lead)
        .update(params.toJson())
        .eq('lead_id', params.leadId ?? -1)
        .select();
    if (response.firstOrNull == null) return false;
    return true;
  }

  @override
  Future<List<LeadModel>?> getAllLeads(GetAllLeadParams params) async {
    var builder = client.from(Constants.table_lead).select();
    if (params.realEstateType != null) {
      builder = builder.eq('property_type', params.realEstateType!);
    }
    if (params.rentalType != null) {
      builder = builder.eq('rental_type', params.rentalType!);
    }
    if (params.status != null) {
      final conditions = [];
      for (String status in params.status!) {
        conditions.add('status.eq.$status');
      }
      builder = builder.or(conditions.join(','));
    }
    if (params.isDesired != null) {
      builder = builder.eq('is_desired', params.isDesired!);
    }

    if (params.minPrice != null) {
      builder = builder.gte('price', params.minPrice!);
    }

    if (params.maxPrice != null) {
      builder = builder.lte('price', params.maxPrice!);
    }

    if (params.minArea != null) {
      builder = builder.gte('area', params.minArea!);
    }

    if (params.maxArea != null) {
      builder = builder.lte('area', params.maxArea!);
    }

    if (params.province != null) {
      builder = builder.eq('city', params.province!);
    }

    if (params.district != null) {
      builder = builder.eq('district', params.district!);
    }

    if (params.uploadedBy != null) {
      builder = builder.eq('uploaded_by', params.uploadedBy!);
    }

    final response = await builder;
    return response.map((e) => LeadModel.fromJson(e)).toList();
  }

  @override
  Future<void> uploadLeadImages(num leadId, List<String> images) async {
    for (String image in images) {
      try {
        await client.from('lead_images').insert({
          'lead_id': leadId,
          'image_url': image,
          'image_type': '.png',
        });
      } catch (_) {}
    }
  }

  @override
  Future<List<String>?> getLeadImages(num leadId) async {
    final response = await client
        .from('lead_images')
        .select('image_url')
        .eq('lead_id', leadId);

    return response.map((e) {
      return client.storage
          .from('spacefinder-cdn')
          .getPublicUrl(e.values.first.replaceAll("spacefinder-cdn/", ""));
    }).toList();
  }
}
