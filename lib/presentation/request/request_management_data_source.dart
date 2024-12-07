import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';
import 'package:spacefinder/presentation/lead/detail/lead_detail_page.dart';
import 'package:spacefinder/presentation/request/request_management_page_c.dart';
import 'package:spacefinder/routes.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../auth/authentication_c.dart';
import 'detail_request_popup.dart';

class RequestManagementDataSource extends DataGridSource {
  RequestManagementDataSource({required List<RequestEntity> requests}) {
    data = requests
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'id', value: e.requestId?.toString() ?? ''),
              DataGridCell<LeadEntity?>(columnName: 'leadCode', value: e.lead),
              DataGridCell<String>(
                  columnName: 'type',
                  value: e.lead?.isDesired == true ? 'Muốn thuê' : 'Cho thuê'),
              DataGridCell<String>(
                  columnName: 'requestType', value: e.requestType ?? '--'),
              DataGridCell<String>(
                  columnName: 'description', value: e.requestDetails ?? '--'),
              DataGridCell<String>(
                  columnName: 'proof', value: e.evidenceFile ?? ''),
              DataGridCell<String>(
                  columnName: 'reviewedBy', value: e.reviewedByName ?? '--'),
              DataGridCell<String>(
                  columnName: 'reviewNote', value: e.reviewNote ?? '--'),
              DataGridCell<String>(columnName: 'status', value: e.status ?? ''),
              DataGridCell<RequestEntity>(columnName: 'action', value: e),
            ]))
        .toList();
    handlePageChange(0, 0);
  }

  List<DataGridRow> paging = [];

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => paging;

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
                _ => 'Không xác định'
              },
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }

      if (e.columnName == 'proof') {
        return GestureDetector(
          onTap: () {
            launchUrlString(e.value);
          },
          child: const Icon(
            Icons.file_copy,
            color: Colors.red,
            size: 24,
          ),
        );
      }

      if (e.columnName == 'action') {
        return buildAction(e.value);
      }

      if (e.columnName == 'leadCode') {
        return GestureDetector(
          onTap: () {
            Routes.goTo(LeadDetailPage(lead: e.value));
          },
          child: Center(
            child: Text(e.value?.code ?? '--',
                style: const TextStyle(
                    color: Color(0xff287098),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff287098))),
          ),
        );
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
      paging = data
          .getRange(startIndex, min(endIndex, data.length))
          .toList(growable: false);
      notifyListeners();
    } else {
      paging = [];
    }

    return true;
  }

  Widget buildAction(RequestEntity requestEntity) {
    final authController = Get.find<AuthenticationController>();
    final user = authController.user.value;
    final status = requestEntity.status ?? '';

    if (user == null) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == 'PENDING') ...{
          GestureDetector(
            onTap: () {
              showConfirmDialog(requestEntity, false);
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
              showConfirmDialog(requestEntity, true);
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
                      content: DetailRequestPopup(
                        request: requestEntity,
                      ),
                    ));
          },
          child: const Icon(
            Icons.visibility,
            size: 16,
          ),
        ),
      ],
    );
  }

  void showConfirmDialog(RequestEntity requestEntity, bool isReject) {
    final noteController = TextEditingController();
    showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 500,
                height: 300,
                child: Container(
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
                          'Bạn có chắc chắn muốn ${isReject ? 'từ chối duyệt' : 'duyệt'} mục này? Hành động này không thể hoàn tác.'),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Ghi chú'),
                      SizedBox(
                        height: 100,
                        child: TextField(
                          controller: noteController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ).paddingSymmetric(horizontal: 8),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Expanded(
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
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                Get.back();

                                final controller =
                                    Get.find<RequestManagementPageController>();
                                await controller.updateRequestStatus(
                                    requestEntity.requestId ?? -1,
                                    isReject ? 'REJECTED' : 'APPROVED',
                                    noteController.text,
                                    Get.find<AuthenticationController>()
                                            .user
                                            .value
                                            ?.userId ??
                                        -1);
                              },
                              child: Expanded(
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
                          ),
                        ],
                      )
                    ],
                  ).paddingAll(8),
                ),
              ),
            ));
  }
}
