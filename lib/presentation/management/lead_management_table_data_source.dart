// ignore_for_file: equal_elements_in_set

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/presentation/contract/create_contract_page.dart';
import 'package:spacefinder/presentation/management/lead_management_c.dart';
import 'package:spacefinder/routes.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'detail_lead_management_popup.dart';
import '../../common.dart';

class LeadTableDataSource extends DataGridSource {
  LeadTableDataSource({required List<LeadEntity> leads}) {
    data = leads
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.code ?? '--'),
              DataGridCell<String>(columnName: 'title', value: e.title ?? '--'),
              DataGridCell<String>(
                  columnName: 'propertyType', value: e.propertyType ?? '--'),
              DataGridCell<String>(
                  columnName: 'rentalType', value: e.rentalType ?? '--'),
              DataGridCell<String>(
                  columnName: 'address',
                  value:
                      '${(e.street ?? '').isNotEmpty ? '${e.street}, ' : ''} ${e.ward ?? ''}, ${e.district ?? ''}, ${e.city ?? ''}'),
              DataGridCell<String>(
                  columnName: 'price',
                  value: (e.price?.toString() ?? '--') == '-1'
                      ? 'Thoả thuận'
                      : e.price?.currencyFormat),
              DataGridCell<String>(
                  columnName: 'area', value: e.area?.toString() ?? '--'),
              DataGridCell<dynamic>(
                  columnName: 'createdAt',
                  value: (e.createdAt as num? ?? -1).ddMMyyyyFormat ?? '--'),
              DataGridCell<String>(
                  columnName: 'status', value: e.status ?? '--'),
              DataGridCell<String>(
                  columnName: 'reviewNote', value: e.reviewNote ?? '--'),
              DataGridCell<String>(
                  columnName: 'reviewedBy', value: e.reviewedByName ?? '--'),
              DataGridCell<LeadEntity>(columnName: 'action', value: e),
            ]))
        .toList();
    handlePageChange(0, 0);
  }

  List<DataGridRow> paginated = [];
  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => paginated;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.columnName == 'status') {
        return Container(
          height: 30,
          decoration: BoxDecoration(
            color: switch (e.value) {
              'PENDING' => Colors.orange,
              'APPROVED' => Colors.green,
              'RENTED' => const Color(0xff287098),
              'REJECTED' => Colors.red,
              _ => Colors.grey
            },
          ),
          child: Center(
            child: Text(
              switch (e.value) {
                'PENDING' => 'Chờ duyệt',
                'APPROVED' => 'Đã duyệt',
                'REJECTED' => 'Từ chối',
                'RENTED' => 'Đã thuê',
                'CLOSED' => 'Đã đóng',
                _ => 'Không xác định'
              },
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
      if (e.columnName == 'action') {
        return buildAction(e.value);
      }

      if (e.columnName == 'reviewedBy') {
        if (e.value.toString().endsWith("@@@")) {
          return Center(
              child: Text(
            e.value.toString().replaceAll("@@@", ""),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.blue),
          ));
        } else {
          return Center(
              child: Text(
            e.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.green),
          ));
        }
      }

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * 4;
    int endIndex = startIndex + 4;
    if (startIndex < data.length) {
      paginated = data
          .getRange(startIndex, min(endIndex, data.length))
          .toList(growable: false);
      notifyListeners();
    } else {
      paginated = [];
    }

    return true;
  }

  Widget buildAction(LeadEntity leadEntity) {
    final authController = Get.find<AuthenticationController>();
    final user = authController.user.value;
    final status = leadEntity.status ?? '';

    if (user == null) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == 'PENDING') ...{
          GestureDetector(
            onTap: () {
              showConfirmDialog(leadEntity, false);
            },
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              showConfirmDialog(leadEntity, true);
            },
            child: const Icon(
              Icons.block,
              color: Colors.red,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        },
        GestureDetector(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: DetailLeadManagementPopup(
                          lead: leadEntity,
                          isEdit: user.userId == leadEntity.uploadedBy),
                    ));
          },
          child: const Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.black87,
            size: 16,
          ),
        ),
        if (user.role == 'ADMIN') ...{
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context!,
                  builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: DetailLeadManagementPopup(
                            lead: leadEntity, isEdit: true),
                      ));
            },
            child: const Tooltip(
              message: 'Chỉnh sửa tin đăng',
              waitDuration: Duration.zero,
              child: Icon(
                Icons.edit_document,
                color: Colors.blue,
                size: 16,
              ),
            ),
          ),
        },
        if (!leadEntity.isDesired) ...{
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Routes.goTo(CreateContractPage(
                propertyCode: leadEntity.code,
                rentalType: leadEntity.rentalType,
              ));
            },
            child: const Tooltip(
              message: 'Tạo hợp đồng',
              waitDuration: Duration.zero,
              child: Icon(
                Icons.post_add,
                color: Colors.purple,
                size: 16,
              ),
            ),
          ),
        },
        if (user.role == 'ADMIN') ...{
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context!,
                  builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: DetailLeadManagementPopup(
                            lead: leadEntity, isEdit: true),
                      ));
            },
            child: const Tooltip(
              message: 'Xoá tin đăng',
              waitDuration: Duration.zero,
              child: Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
                size: 16,
              ),
            ),
          ),
        },
      ],
    );
  }

  void showConfirmDialog(LeadEntity leadEntity, bool isReject) {
    final noteController = TextEditingController();
    showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  width: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isReject ? 'Từ chối duyệt' : 'Xác nhận duyệt',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Bạn có chắc chắn muốn ${isReject ? 'từ chối duyệt' : 'duyệt'} mục này từ Danh sách tin đăng? Hành động này không thể hoàn tác.'),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Ghi chú'),
                      SizedBox(
                        height: 100,
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          controller: noteController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue)),
                                child: const Center(
                                  child: Text(
                                    'Huỷ',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                Get.back();

                                final controller =
                                    Get.find<LeadManagementController>();
                                await controller.updateLeadStatus(
                                    leadEntity.leadId ?? -1,
                                    isReject ? 'REJECTED' : 'APPROVED');
                                await controller.updateLeadReviewNote(
                                    leadEntity.leadId ?? -1,
                                    noteController.text);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue),
                                child: const Center(
                                  child: Text(
                                    'Xác nhận',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
