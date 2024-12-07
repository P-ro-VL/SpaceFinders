// ignore_for_file: equal_elements_in_set

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../management/detail_lead_management_popup.dart';

class LeadHistoryDataSource extends DataGridSource {
  LeadHistoryDataSource({required List<LeadEntity> leads}) {
    data = leads
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.code ?? ''),
              DataGridCell<String>(columnName: 'title', value: e.title ?? '--'),
              DataGridCell<String>(
                  columnName: 'type',
                  value: e.isDesired == true ? 'Muốn thuê' : 'Cho thuê'),
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
                      : e.price?.toString()),
              DataGridCell<String>(
                  columnName: 'area', value: e.area?.toString() ?? '--'),
              DataGridCell<String>(
                  columnName: 'createdAt',
                  value: (e.createdAt as int? ?? 0).ddMMyyyyFormat),
              DataGridCell<String>(
                  columnName: 'status', value: e.status ?? '--'),
              DataGridCell<LeadEntity>(columnName: 'action', value: e),
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
                'RENTED' => 'Đã thuê',
                'CLOSED' => 'Đã đóng',
                'REJECTED' => 'Từ chối',
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

  Widget buildAction(LeadEntity leadEntity) {
    final authController = Get.find<AuthenticationController>();
    final user = authController.user.value;

    if (user == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content:
                      DetailLeadManagementPopup(lead: leadEntity, isEdit: true),
                ));
      },
      child: const Icon(
        Icons.edit_document,
        color: Colors.blue,
        size: 16,
      ),
    );
  }
}
