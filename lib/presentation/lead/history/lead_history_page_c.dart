import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/usecase/lead/get_all_lead_use_case.dart';

class LeadHistoryPageController extends GetxController {
  final getAllLeadUseCase =
      GetAllLeadUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));

  final isLoading = RxBool(false);
  final leads = RxList<LeadEntity>();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading.value = true;

    final authController = Get.find<AuthenticationController>();
    final response = await getAllLeadUseCase
        .call(GetAllLeadParams(uploadedBy: authController.user.value?.userId));
    response.fold((l) {}, (r) {
      leads.assignAll(r);
    });

    isLoading.value = false;
  }
}
