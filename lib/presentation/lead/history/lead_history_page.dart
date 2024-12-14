import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/lead/history/lead_history_data_source.dart';
import 'package:spacefinder/presentation/lead/history/lead_history_page_c.dart';
import 'package:spacefinder/presentation/request/create_request_popup.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LeadHistoryPage extends StatefulWidget {
  LeadHistoryPage({super.key});

  @override
  State<LeadHistoryPage> createState() => _LeadHistoryPageState();
}

class _LeadHistoryPageState extends State<LeadHistoryPage> {
  late LeadHistoryDataSource dataSource;

  final controller = Get.put(LeadHistoryPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      dataSource = LeadHistoryDataSource(leads: controller.leads);
      return controller.isLoading.value
          ? const CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Ln.i?.leadIhistory ?? '',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff287098))),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: CreateRequestPopup(),
                            ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87.withOpacity(0.1),
                              blurRadius: 10),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (Get.find<AuthenticationController>()
                                  .user
                                  .value
                                  ?.role ==
                              'CUSTOMER')
                            IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xff287098),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.support_agent,
                                        color: Colors.white, size: 20),
                                    const SizedBox(width: 4),
                                    Text(Ln.i?.leadIcreateRequest ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 40),
                          SfDataGrid(
                            source: dataSource,
                            showHorizontalScrollbar: true,
                            rowHeight: 60,
                            headerRowHeight: 60,
                            rowsPerPage: 4,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'title',
                                  columnWidthMode:
                                      ColumnWidthMode.fitByCellValue,
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Tiêu đề',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'type',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Loại tin đăng',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'propertyType',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Loại BĐS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              GridColumn(
                                  columnName: 'rentalType',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Hình thức thuê',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'address',
                                  columnWidthMode:
                                      ColumnWidthMode.fitByCellValue,
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Địa chỉ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'price',
                                  columnWidthMode: ColumnWidthMode.fill,
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Mức giá',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'area',
                                  columnWidthMode: ColumnWidthMode.fill,
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Diện tích (m2)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'createdAt',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Ngày tạo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'status',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Trạng thái',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                              GridColumn(
                                  columnName: 'action',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Hành động',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SfDataPager(
                              pageCount: controller.leads.length / 4,
                              delegate: dataSource),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 128);
    });
  }
}
