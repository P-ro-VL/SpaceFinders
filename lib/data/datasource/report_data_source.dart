import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;
import 'package:excel/excel.dart';

abstract class ReportDataSource {
  Future<bool> getReportTotalRevenue({num? fromDate, num? toDate});
  Future<bool> getReportTotalLeads({num? fromDate, num? toDate});
  Future<bool> getReportSalePerformance({num? fromDate, num? toDate});

  Future<bool> getAllLeads(bool isDesired);
  Future<bool> getAllContracts();
  Future<bool> getAllRequests();
}

class ReportDataSourceImpl extends ReportDataSource {
  final client = Supabase.instance.client;

  @override
  Future<bool> getReportSalePerformance({num? fromDate, num? toDate}) async {
    try {
      await client.rpc('execute_query',
          params: {'query': 'DROP VIEW report_sale_performance'});
    } catch (_) {}

    final query = """
      CREATE VIEW report_sale_performance AS
      SELECT
          CONCAT('2', LPAD(u.user_id::TEXT, 7, '0')) AS "Mã nhân viên",
          u.full_name AS "Tên nhân viên",
          COUNT(c.sales_id) AS "Tổng số hợp đồng thành công",
          SUM(c.rental_price) AS "Tổng giá trị hợp đồng",
          SUM(
              CASE 
                  WHEN l.rental_type = 'Ngắn hạn qua đêm' THEN c.rental_price * 0.1
                  WHEN l.rental_type = 'Dài hạn' THEN c.rental_price * 0.08
                  ELSE 0
              END
          ) AS "Tổng doanh thu"
      FROM 
          users u
      JOIN 
          contracts c ON u.user_id = c.sales_id
      JOIN 
          lead_listings l ON c.lead_id = l.lead_id
      WHERE 
          (c.status = 'Đã hoàn thành') AND (c.updated_at BETWEEN ${(fromDate ?? 0)} AND ${(toDate ?? DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch)})
      GROUP BY 
          u.user_id, u.full_name
      ORDER BY 
          u.user_id
    """;

    await client.rpc('execute_query', params: {'query': query});

    final data = await client.from('report_sale_performance').select();
    await _writeToExcel(data, 'Báo cáo hiệu quả kinh doanh của nhân viên');
    return true;
  }

  @override
  Future<bool> getReportTotalLeads({num? fromDate, num? toDate}) async {
    try {
      await client.rpc('execute_query',
          params: {'query': 'DROP VIEW report_total_leads'});
    } catch (_) {}

    final query = """
      CREATE OR REPLACE VIEW report_total_leads AS
      SELECT 
          CONCAT('1', LPAD(u.user_id::TEXT, 7, '0')) AS "Mã khách hàng",
          u.full_name AS "Tên khách hàng",
          COUNT(l.uploaded_by) AS "Tổng số lượng tin đăng",
          SUM(CASE WHEN l.is_desired = FALSE THEN 1 ELSE 0 END) AS "Số lượng tin đăng cho thuê",
          SUM(CASE WHEN l.is_desired = TRUE THEN 1 ELSE 0 END) AS "Số lượng tin đăng muốn thuê"
      FROM 
          users u
      LEFT JOIN 
          lead_listings l
      ON 
          u.user_id = l.uploaded_by AND u.role = 'CUSTOMER'
      WHERE 
          l.updated_at BETWEEN ${(fromDate ?? 0)} AND ${(toDate ?? DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch)}
      GROUP BY 
          u.user_id, u.full_name
    """;

    await client.rpc('execute_query', params: {'query': query});

    final data = await client.from('report_total_leads').select();
    await _writeToExcel(data, 'Báo cáo hoạt động đăng tin của khách hàng');
    return true;
  }

  @override
  Future<bool> getReportTotalRevenue({num? fromDate, num? toDate}) async {
    try {
      await client.rpc('execute_query',
          params: {'query': 'DROP VIEW report_total_revenue'});
    } catch (_) {}

    final query = """
      CREATE OR REPLACE VIEW report_total_revenue AS
      SELECT 
          l.code AS "Mã BĐS",
          COUNT(c.contract_id) AS "Tổng số hợp đồng",
          SUM(c.rental_price) AS "Tổng giá trị hợp đồng",
          SUM(
              CASE 
                  WHEN l.rental_type = 'Ngắn hạn qua đêm' THEN c.rental_price * 0.08
                  WHEN l.rental_type = 'Dài hạn' THEN c.rental_price * 0.1
                  ELSE 0
              END
          ) AS "Tổng doanh thu"
      FROM 
          lead_listings l
      LEFT JOIN 
          contracts c
      ON 
          l.code = c.code
      WHERE 
          c.updated_at BETWEEN ${(fromDate ?? 0)} AND ${(toDate ?? DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch)}
      GROUP BY 
          l.code
      HAVING 
          SUM(c.rental_price) > 0
    """;

    await client.rpc('execute_query', params: {'query': query});

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

  @override
  Future<bool> getAllRequests() async {
    final data = await client.from('requests');
    await _writeToExcel(data, 'Danh sách yêu cầu sau duyệt');
    return true;
  }
}
