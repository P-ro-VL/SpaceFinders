import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/datasource/request_data_source.dart';
import 'package:spacefinder/data/datasource/user_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/data/repository/request_repository_impl.dart';
import 'package:spacefinder/data/repository/user_repository_impl.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';
import 'package:spacefinder/domain/usecase/get_user_detail_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_lead_detail_use_case.dart';
import 'package:spacefinder/domain/usecase/request/get_all_requests_use_case.dart';
import 'package:spacefinder/domain/usecase/request/update_request_use_case.dart';
import 'package:spacefinder/presentation/request/request_management_data_source.dart';

class RequestManagementPageController extends GetxController {
  final isLoading = RxBool(true);
  final requests = RxList<RequestEntity>();

  final filterStatus = RxString('All');
  final filterLeadType = RxString('All');
  final filterRequestType = RxString('All');

  final dataSource = Rxn<RequestManagementDataSource>();

  final requestRepository = RequestRepositoryImpl(RequestDataSourceImpl());

  final getLeadDetailUseCase =
      GetLeadDetailUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
  final getUserDetailUseCase =
      GetUserDetailUseCase(UserRepositoryImpl(UserDataSourceImpl()));

  late final getAllRequestsUseCase = GetAllRequestsUseCase(requestRepository);
  late final updateRequestUseCase = UpdateRequestUseCase(requestRepository);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void clearFilter() {
    filterStatus.value = 'All';
    filterLeadType.value = 'All';
    filterRequestType.value = 'All';

    fetchData();
  }

  Future<bool> updateRequestStatus(dynamic requestId, String newStatus,
      String reviewNote, num reviewedBy) async {
    final params = UpdateRequestParams(
        status: newStatus,
        requestId: requestId,
        reviewNote: reviewNote,
        reviewedBy: reviewedBy);
    await updateRequestUseCase.call(params);
    fetchData();
    return true;
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final params = GetAllRequestsParams(
      requestStatus: filterStatus.value == 'All'
          ? null
          : switch (filterStatus.value) {
              'Đã duyệt' => 'APPROVED',
              'Chờ duyệt' => 'PENDING',
              'Từ chối' => 'REJECTED',
              _ => null
            },
      requestType:
          filterRequestType.value == 'All' ? null : filterRequestType.value,
    );
    final response = await getAllRequestsUseCase.call(params);
    await response.fold((l) async {}, (r) async {
      for (final request in r) {
        if (request.reviewedBy != null) {
          final userInfo =
              (await getUserDetailUseCase.call(request.reviewedBy ?? -1)).right;
          request.reviewedByName = userInfo.fullName;
        }

        if (request.leadId != null) {
          final lead =
              (await getLeadDetailUseCase.call(request.leadId ?? -1)).right;
          request.lead = lead;
        }
      }

      requests.value = r;
      if (filterLeadType.value != 'All') {
        requests.value = requests
            .where((e) =>
                e.lead?.isDesired ==
                (filterLeadType.value == 'Muốn thuê' ? true : false))
            .toList();
      }
      dataSource.value = RequestManagementDataSource(requests: requests);
    });
    isLoading.value = false;
  }
}
