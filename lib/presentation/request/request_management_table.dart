import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/request/request_management_page_c.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RequestManagementTable extends StatelessWidget {
  RequestManagementTable({super.key});

  final controller = Get.find<RequestManagementPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const SizedBox.shrink()
          : Column(
              children: [
                SfDataGrid(
                  source: controller.dataSource.value!,
                  rowHeight: 60,
                  headerRowHeight: 60,
                  columnWidthMode: ColumnWidthMode.fill,
                  showHorizontalScrollbar: true,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'id',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'ID',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'leadCode',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Mã tin đăng BĐS',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'type',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Loại tin đăng',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'requestType',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Loại yêu cầu',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'description',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Mô tả chi tiết',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'proof',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Minh chứng đính kèm',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'reviewedBy',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Người duyệt',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'reviewNote',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Ghi chú duyệt',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'status',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Trạng thái',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'action',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Hành động',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                    height: 60,
                    child: SfDataPager(
                      delegate: controller.dataSource.value!,
                      pageCount: max(1, controller.requests.length / 4),
                      direction: Axis.horizontal,
                    )),
              ],
            ),
    );
  }
}
