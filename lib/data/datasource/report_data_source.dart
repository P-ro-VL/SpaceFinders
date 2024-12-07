import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;
import 'package:excel/excel.dart';

abstract class ReportDataSource {
  Future<bool> getReportTotalRevenue();
  Future<bool> getReportTotalLeads();
  Future<bool> getReportSalePerformance();

  Future<bool> getAllLeads(bool isDesired);
  Future<bool> getAllContracts();
}

class ReportDataSourceImpl extends ReportDataSource {
  final client = Supabase.instance.client;

  @override
  Future<bool> getReportSalePerformance() async {
    final data = await client.from('report_sale_performance').select();
    await _writeToExcel(data, 'Báo cáo hiệu quả kinh doanh của nhân viên');
    return true;
  }

  @override
  Future<bool> getReportTotalLeads() async {
    final data = await client.from('report_total_leads').select();
    await _writeToExcel(data, 'Báo cáo hoạt động đăng tin của khách hàng');
    return true;
  }

  @override
  Future<bool> getReportTotalRevenue() async {
    final data = await client.from('report_total_revenue').select();
    await _writeToExcel(data, 'Báo cáo doanh thu theo bất động sản');
    return true;
  }

  Future<void> _writeToExcel(
      List<Map<String, dynamic>> data, String name) async {
    var excel = Excel.createExcel(); // Create a new Excel file
    Sheet sheet = excel['Sheet1']; // Add a new sheet

    // Writing headers (if needed)
    if (data.isNotEmpty) {
      sheet.appendRow(
          data.first.keys.map((e) => TextCellValue(e.toString())).toList());
    }

    // Writing data rows
    for (var row in data) {
      sheet.appendRow(
          row.values.map((e) => TextCellValue(e.toString())).toList());
    }

    // Encoding the Excel file to bytes
    var bytes = excel.encode();

    // Create a Blob for the file in the browser
    final blob = html.Blob([Uint8List.fromList(bytes!)]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a download link and trigger the download
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = '$name.xlsx'; // File name for the download
    anchor.click();

    // Revoke the URL after the download is initiated
    html.Url.revokeObjectUrl(url);
  }

  @override
  Future<bool> getAllContracts() async {
    final data = await client.from('contracts').select();
    await _writeToExcel(data, 'Danh sách hợp đồng');
    return true;
  }

  @override
  Future<bool> getAllLeads(bool isDesired) async {
    final data =
        await client.from('lead_listings').select().eq('is_desired', isDesired);
    await _writeToExcel(
        data,
        !isDesired
            ? 'Danh sách tin đăng cho thuê'
            : 'Danh sách tin đăng muốn thuê');
    return true;
  }
}