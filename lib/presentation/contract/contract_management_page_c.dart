import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/contract_data_source.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/datasource/user_data_source.dart';
import 'package:spacefinder/data/repository/contract_repository_impl.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/data/repository/user_repository_impl.dart';
import 'package:spacefinder/domain/usecase/contract/get_all_contracts_use_case.dart';
import 'package:spacefinder/domain/usecase/get_user_detail_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_lead_detail_use_case.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../domain/entity/contract_entity.dart';
import 'contract_management_table_data_source.dart';

class ContractManagementPageController extends GetxController {
  final isLoading = RxBool(true);

  final getUserDetailUseCase =
      GetUserDetailUseCase(UserRepositoryImpl(UserDataSourceImpl()));
  final getLeadDetailUseCase =
      GetLeadDetailUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
  final getAllContractsUseCase =
      GetAllContractsUseCase(ContractRepositoryImpl(ContractDataSourceImpl()));

  final contracts = RxList<ContractEntity>();

  late ContractTableDataSource dataSource;

  final filterContractStatus = RxString('All');
  final filterPropertyType = RxString('All');
  final filterRentalType = RxString('All');

  bool get hasFilter =>
      filterContractStatus.value != 'All' ||
      filterPropertyType.value != 'All' ||
      filterRentalType.value != 'All';

  final keyword = RxString('');

  @override
  void onInit() {
    fetchData();
    debounce(keyword, (value) {
      fetchData();
    }, time: const Duration(milliseconds: 300));
    super.onInit();
  }

  void clearFilter() {
    filterContractStatus.value = 'All';
    filterPropertyType.value = 'All';
    filterRentalType.value = 'All';

    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    final response = await getAllContractsUseCase
        .call(GetAllContractsParams(keyword: keyword.value));
    response.fold((l) {
      isLoading.value = false;
    }, (r) async {
      final mappedContracts = await Future.wait(r.map((contract) async {
        final agent = await getUserDetailUseCase.call(contract.saleId ?? -1);
        final lead = await getLeadDetailUseCase.call(contract.leadId ?? -1);

        contract.agentName = agent.right.fullName ?? '';
        contract.rentalType = lead.right.rentalType ?? '';
        contract.propertyType = lead.right.propertyType ?? '';
        contract.commission =
            (lead.right.rentalType == 'Dài hạn' ? 0.08 : 0.1) *
                (contract.rentalPrice ?? 1);

        return contract;
      }));

      contracts.assignAll(mappedContracts.where((contract) {
        bool contractStatus = true;
        bool propertyType = true;
        bool rentalType = true;

        if (filterContractStatus.value != 'All') {
          contractStatus = filterContractStatus.value == contract.status;
        }

        if (filterPropertyType.value != 'All') {
          propertyType = filterPropertyType.value == contract.propertyType;
        }

        if (filterRentalType.value != 'All') {
          rentalType = filterRentalType.value == contract.rentalType;
        }

        return contractStatus && propertyType && rentalType;
      }));

      dataSource = ContractTableDataSource(contracts: contracts);

      isLoading.value = false;
    });
  }
}
