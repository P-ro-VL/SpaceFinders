import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/model/lead_model.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/domain/usecase/lead/create_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_all_lead_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

class LeadRepositoryImpl extends LeadRepository {
  final LeadDataSource dataSource;

  LeadRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, LeadEntity>> createLead(
      CreateLeadParams params) async {
    final response = await dataSource.createLead(params);
    return Either.cond(response != null, FetchFailure(), response!.toEntity);
  }

  @override
  Future<Either<FailureEntity, LeadEntity>> getLead(num? leadId) async {
    final response = await dataSource.getLead(leadId);
    return Either.cond(response != null, FetchFailure(), response!.toEntity);
  }

  @override
  Future<Either<FailureEntity, bool>> updateLead(params) async {
    final response = await dataSource.updateLead(params);
    return Either.cond(response != null, FetchFailure(), response!);
  }

  @override
  Future<Either<FailureEntity, List<LeadEntity>>> getAllLeads(
      GetAllLeadParams params) async {
    final response = await dataSource.getAllLeads(params);
    return Either.cond(response != null, FetchFailure(),
        response!.map((e) => e.toEntity).toList());
  }

  @override
  Future<Either<FailureEntity, List<String>>> getLeadImages(num leadId) async {
    final response = await dataSource.getLeadImages(leadId);
    return Either.cond(response != null, FailureEntity(), response!);
  }

  @override
  Future<void> uploadLeadImages(num leadId, List<String> images) async {
    await dataSource.uploadLeadImages(leadId, images);
  }

  @override
  Future<Either<FailureEntity, void>> deleteLead(num? leadId) async {
    await dataSource.deleteLead(leadId);
    return Either.cond(true, FailureEntity(), null);
  }
}
