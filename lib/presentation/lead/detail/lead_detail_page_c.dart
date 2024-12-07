import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/usecase/lead/get_lead_images_use_case.dart';

class LeadDetailPageController {
  final isLoading = RxBool(true);

  final lead = Rxn<LeadEntity>();
  final images = RxList<String>();

  final getLeadImagesUseCase =
      GetLeadImagesUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));

  void fetchData() async {
    images.assignAll(
        (await getLeadImagesUseCase.call(lead.value?.leadId ?? -1)).right);
    isLoading.value = false;
  }
}
