import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/contract/contract_management_page_c.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ContractManagementTable extends StatefulWidget {
  const ContractManagementTable({super.key});

  @override
  State<ContractManagementTable> createState() =>
      _ContractManagementTableState();
}

class _ContractManagementTableState extends State<ContractManagementTable> {
  final controller = Get.put(ContractManagementPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? CircularProgressIndicator()
          : Column(
              children: [
                SfDataGrid(
                  source: controller.dataSource,
                  showHorizontalScrollbar: true,
                  rowHeight: 60,
                  headerRowHeight: 60,
                  columnWidthMode: ColumnWidthMode.auto,
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
                        columnName: 'code',
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Mã BĐS',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'agent_name',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Tên nhân viên môi giới',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'price',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Giá trị hợp đồng',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'type',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Hình thức cho thuê',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'deposit',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Số tiền cọc',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'commission',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Tổng tiền hoa hồng',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'start_date',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Ngày hiệu lực',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'end_date',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Ngày hết hạn',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'file',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'File hợp đồng',
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
                const SizedBox(
                  height: 8,
                ),
                Container(
                    height: 50,
                    child: SfDataPager(
                      delegate: controller.dataSource,
                      pageCount: max(1, controller.contracts.length / 4),
                      direction: Axis.horizontal,
                    )),
              ],
            ),
    );
  }
}
