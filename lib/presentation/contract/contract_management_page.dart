import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/report_data_source.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/contract/contract_management_page_c.dart';
import 'package:spacefinder/presentation/contract/contract_management_table.dart';
import 'package:spacefinder/routes.dart';

import '../../constants.dart';
import 'create_contract_page.dart';

class ContractManagementPage extends StatefulWidget {
  const ContractManagementPage({super.key});

  @override
  State<ContractManagementPage> createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage>
    with FormMixin {
  final controller = Get.put(ContractManagementPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Ln.i?.contractImanagement ?? '',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff287098),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Routes.goTo(CreateContractPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff287098),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_square,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Text(Ln.i?.contractIcreate ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ContractManagementFilterSection(),
                  if (controller.hasFilter)
                    GestureDetector(
                      onTap: () {
                        controller.clearFilter();
                      },
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xff2B78A3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: const Text('Xoá tìm kiếm',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff2B78A3)))
                                .paddingSymmetric(vertical: 8)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              buildInput(
                  text: Ln.i?.leadIsearchByCode,
                  defaultValue: controller.keyword.value,
                  isRequired: false,
                  onChanged: (keyword) async {
                    controller.keyword.value = keyword;
                  }),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    final reportDataSource = ReportDataSourceImpl();
                    reportDataSource.getAllContracts();
                  },
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xff2B78A3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.file_download_outlined,
                            color: Color(0xff2B78A3)),
                        const SizedBox(width: 8),
                        const Text('Xuất Excel',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff2B78A3)))
                            .paddingSymmetric(vertical: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const ContractManagementTable(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 32).marginOnly(top: 16);
  }
}

class _ContractManagementFilterSection extends StatelessWidget with FormMixin {
  final controller = Get.find<ContractManagementPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 12,
        children: [
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Trạng thái hợp đồng',
                value: controller.filterContractStatus.value,
                values: ['All', 'Đang xử lý', 'Đã hoàn thành'],
                isRequired: false,
                onSelect: (item) {
                  controller.filterContractStatus.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Loại BĐS',
                value: controller.filterPropertyType.value,
                values: ['All', ...Constants.default_property_types.names],
                isRequired: false,
                onSelect: (item) {
                  controller.filterPropertyType.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Hình thức thuê',
                value: controller.filterRentalType.value,
                values: ['All', 'Muốn thuê', 'Cho thuê'],
                isRequired: false,
                onSelect: (item) {
                  controller.filterRentalType.value = item;
                  controller.fetchData();
                }),
          ),
        ],
      ),
    );
  }
}
