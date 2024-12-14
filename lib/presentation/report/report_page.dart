import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/data/datasource/report_data_source.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with FormMixin {
  final reportDataSource = ReportDataSourceImpl();

  final reportTypes = [
    '--- Chọn báo cáo thống kê ---',
    'Báo cáo doanh thu theo BĐS',
    'Báo cáo hoạt động đăng tin của khách hàng',
    'Báo cáo hiệu quả kinh doanh của nhân viên',
  ];

  String selectedReportType = '';
  final fromDateValue = RxNum(0);
  final toDateValue = RxNum(
      DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text('Báo cáo thống kê',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildDropdown(
              text: 'Chọn báo cáo thống kê',
              value: '--- Chọn báo cáo thống kê ---',
              values: reportTypes,
              onSelect: (value) {
                selectedReportType = value;
              }),
          const SizedBox(height: 20),
          const Text('Điều kiện lọc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: buildDatePicker(
                      text: 'Từ ngày',
                      value: fromDateValue.value.ddMMyyyyFormat,
                      onSelect: (date) {
                        fromDateValue.value = date.millisecondsSinceEpoch;
                      }),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: buildDatePicker(
                      text: 'Đến ngày',
                      value: toDateValue.value.ddMMyyyyFormat,
                      onSelect: (date) {
                        toDateValue.value = date.millisecondsSinceEpoch;
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _export(selectedReportType);
            },
            child: Container(
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  'Xác nhận',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 32),
    );
  }

  Future<void> _export(dynamic value) async {
    switch (value) {
      case 'Báo cáo doanh thu theo BĐS':
        {
          await reportDataSource.getReportTotalRevenue(
              fromDate: fromDateValue.value, toDate: toDateValue.value);
          break;
        }
      case 'Báo cáo hoạt động đăng tin của khách hàng':
        {
          await reportDataSource.getReportTotalLeads(
              fromDate: fromDateValue.value, toDate: toDateValue.value);
          break;
        }
      case 'Báo cáo hiệu quả kinh doanh của nhân viên':
        {
          await reportDataSource.getReportSalePerformance(
              fromDate: fromDateValue.value, toDate: toDateValue.value);
          break;
        }
    }
  }
}
