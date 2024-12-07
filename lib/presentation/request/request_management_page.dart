import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/request/request_management_page_c.dart';

import 'request_management_table.dart';

class RequestManagementPage extends StatefulWidget {
  const RequestManagementPage({super.key});

  @override
  State<RequestManagementPage> createState() => _RequestManagementPageState();
}

class _RequestManagementPageState extends State<RequestManagementPage> {
  final controller = Get.put(RequestManagementPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quản lý yêu cầu sau duyệt tin đăng Bất động sản',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff287098),
                  )),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _RequestManagementFilterSection(),
                        if (controller.filterLeadType.value != 'All' ||
                            controller.filterRequestType.value != 'All' ||
                            controller.filterStatus.value != 'All')
                          GestureDetector(
                            onTap: () {
                              controller.clearFilter();
                            },
                            child: Container(
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: const Color(0xff2B78A3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                  child: const Text('Xoá tìm kiếm',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff2B78A3)))
                                      .paddingSymmetric(vertical: 8)),
                            ),
                          ),
                      ],
                    ),
                    RequestManagementTable(),
                  ],
                ),
              )
            ],
          )).paddingAll(32);
  }
}

class _RequestManagementFilterSection extends StatelessWidget with FormMixin {
  final controller = Get.put(RequestManagementPageController());

  final filterStatuses = ['All', 'Chờ duyệt', 'Từ chối', 'Đã duyệt'];
  final filterLeadTypes = ['All', 'Muốn thuê', 'Cho thuê'];
  final filterRequestTypes = ['All', 'Gỡ', 'Gia hạn'];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 12,
        children: [
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Trạng thái yêu cầu',
                value: controller.filterStatus.value,
                values: filterStatuses,
                isRequired: false,
                onSelect: (item) {
                  controller.filterStatus.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Loại tin đăng',
                value: controller.filterLeadType.value,
                values: filterLeadTypes,
                isRequired: false,
                onSelect: (item) {
                  controller.filterLeadType.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Loại yêu cầu',
                value: controller.filterRequestType.value,
                values: filterRequestTypes,
                isRequired: false,
                onSelect: (item) {
                  controller.filterRequestType.value = item;
                  controller.fetchData();
                }),
          ),
        ],
      ),
    );
  }
}
