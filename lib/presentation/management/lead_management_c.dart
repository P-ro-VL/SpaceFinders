import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/datasource/user_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/data/repository/user_repository_impl.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/usecase/get_user_detail_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_all_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/update_lead_use_case.dart';

import '../../domain/entity/user_entity.dart';
import 'lead_management_table_data_source.dart';

class LeadManagementController extends GetxController {
  LeadManagementController(bool isDemand) {
    isNeedRentDemand.value = isDemand;
  }

  final repository = LeadRepositoryImpl(LeadDataSourceImpl());

  late GetAllLeadUseCase getAllLeadUseCase = GetAllLeadUseCase(repository);
  late UpdateLeadUseCase updateLeadUseCase = UpdateLeadUseCase(repository);
  final getUserDetailUseCase =
      GetUserDetailUseCase(UserRepositoryImpl(UserDataSourceImpl()));

  final authController = Get.find<AuthenticationController>();

  final isLoading = RxBool(false);
  final isNeedRentDemand = RxBool(true);

  final leads = RxList<LeadEntity>();

  final filterLeadStatus = RxString('All');
  final filterPropertyType = RxString('All');
  final filterRentalType = RxString('All');
  final filterMinPriceRange = RxDouble(0);
  final filterMaxPriceRange = RxDouble(50000000);
  final filterMinAreaRange = RxDouble(0);
  final filterMaxAreaRange = RxDouble(300);

  bool get hasFilter =>
      filterLeadStatus.value != 'All' ||
      filterPropertyType.value != 'All' ||
      filterRentalType.value != 'All' ||
      filterMinPriceRange.value != 0 ||
      filterMaxPriceRange.value != 50000000 ||
      filterMinAreaRange.value != 0 ||
      filterMaxAreaRange.value != 300;

  final keyword = RxString('');
  DateTime lastSearch = DateTime.now();
  LeadTableDataSource dataSource = LeadTableDataSource(leads: []);

  @override
  void onInit() {
    fetchData();
    debounce(keyword, (value) {
      fetchData();
    }, time: const Duration(milliseconds: 300));
    super.onInit();
  }

  Future<void> clearFilter() async {
    filterLeadStatus.value = 'All';
    filterPropertyType.value = 'All';
    filterRentalType.value = 'All';
    filterMinPriceRange.value = 0;
    filterMaxPriceRange.value = 50000000;
    filterMinAreaRange.value = 0;
    filterMaxAreaRange.value = 1000;

    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final params = GetAllLeadParams(
      isDesired: isNeedRentDemand.value,
      status: filterLeadStatus.value == 'All'
          ? null
          : [
              switch (filterLeadStatus.value) {
                'Chờ duyệt' => 'PENDING',
                'Đã duyệt' => 'APPROVED',
                'Từ chối' => 'REJECTED',
                'Đã thuê' => 'RENTED',
                _ => 'CLOSED',
              }
            ],
      realEstateType:
          filterPropertyType.value == 'All' ? null : filterPropertyType.value,
      rentalType:
          filterRentalType.value == 'All' ? null : filterRentalType.value,
      minPrice: filterMinPriceRange.value,
      maxPrice: filterMaxPriceRange.value == 50000000
          ? null
          : filterMaxPriceRange.value,
      minArea: filterMinAreaRange.value,
      maxArea:
          filterMaxAreaRange.value == 300 ? null : filterMaxAreaRange.value,
      propertyCodeKeyword: keyword.value,
    );
    final response = await getAllLeadUseCase.call(params);
    response.fold((l) {}, (r) async {
      Map<num, UserEntity> userCache = {};
      for (final lead in r) {
        if (lead.uploadedBy != null && lead.uploadedBy != -1) {
          if (userCache.containsKey(lead.uploadedBy ?? -1)) {
            lead.uploadedByName =
                userCache[lead.uploadedBy ?? -1]?.fullName ?? '--';
          } else {
            final res = await getUserDetailUseCase.call(lead.uploadedBy!);
            lead.uploadedByName = res.right.fullName ?? '--';
            userCache[lead.uploadedBy!] = res.right;
          }
        }

        if (lead.uploadedBy ==
            Get.find<AuthenticationController>().user.value?.userId) {
          lead.reviewedByName = "${lead.uploadedByName ?? ''}@@@";
        } else if (lead.reviewedBy != null && lead.reviewedBy != -1) {
          if (userCache.containsKey(lead.reviewedBy ?? -1)) {
            lead.reviewedByName =
                userCache[lead.reviewedBy ?? -1]?.fullName ?? '--';
          } else {
            final res = await getUserDetailUseCase.call(lead.reviewedBy!);
            lead.reviewedByName = res.right.fullName ?? '--';
            userCache[lead.reviewedBy!] = res.right;
          }
        }
      }
      leads.assignAll(r);
      dataSource = LeadTableDataSource(leads: leads);
      isLoading.value = false;
    });
  }

  Future<bool> updateLeadStatus(num leadId, String newStatus) async {
    isLoading.value = true;
    final params = UpdateLeadParams(leadId, status: newStatus);
    final response = await updateLeadUseCase.call(params);
    isLoading.value = false;
    fetchData();
    return response.fold((l) => false, (r) => true);
  }

  Future<void> updateLeadReviewNote(num leadId, String note) async {
    isLoading.value = true;
    final params = UpdateLeadParams(leadId,
        reviewNote: note, reviewedBy: authController.user.value?.userId ?? -1);
    final response = await updateLeadUseCase.call(params);
    isLoading.value = false;
    fetchData();
    return response.fold((l) => false, (r) => true);
  }
}
