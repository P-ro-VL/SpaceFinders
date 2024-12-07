// ignore_for_file: equal_elements_in_set

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/domain/entity/contract_entity.dart';
import 'package:spacefinder/presentation/contract/detail_contract_popup_w.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContractTableDataSource extends DataGridSource {
  ContractTableDataSource({required List<ContractEntity> contracts}) {
    data = contracts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<num>(columnName: 'id', value: e.contractId ?? -1),
              DataGridCell<String>(columnName: 'code', value: e.code ?? '--'),
              DataGridCell<String>(
                  columnName: 'agent_name', value: e.agentName ?? '--'),
              DataGridCell<String>(
                  columnName: 'price',
                  value: (e.rentalPrice ?? 0).currencyFormat),
              DataGridCell<String>(
                  columnName: 'type', value: e.rentalType ?? '--'),
              DataGridCell<String>(
                  columnName: 'deposit',
                  value: (e.depositAmount ?? 0).currencyFormat),
              DataGridCell<String>(
                  columnName: 'commission',
                  value: (e.commission ?? 0).currencyFormat),
              DataGridCell<String>(
                  columnName: 'start_date',
                  value: e.startDate?.ddMMyyyyFormat ?? '--'),
              DataGridCell<String>(
                  columnName: 'end_date',
                  value: e.endDate?.ddMMyyyyFormat ?? '--'),
              DataGridCell<String>(columnName: 'file', value: e.url),
              DataGridCell<String>(
                  columnName: 'status', value: e.status ?? '--'),
              DataGridCell<ContractEntity>(columnName: 'action', value: e),
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
              'Đã hoàn thành' => Colors.green,
              _ => Colors.orange
            },
          ),
          child: Center(
            child: Text(
              e.value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
      if (e.columnName == 'action') {
        return buildAction(e.value);
      }
      if (e.columnName == 'file') {
        return GestureDetector(
          onTap: () {
            launchUrlString(e.value);
          },
          child: Icon(
            Icons.file_present_rounded,
            color: Colors.red[800],
            size: 24,
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
    int startIndex = newPageIndex * 10;
    int endIndex = startIndex + 10;
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

  Widget buildAction(ContractEntity contractEntity) {
    final authController = Get.find<AuthenticationController>();
    final user = authController.user.value;
    if (user == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: DetailContractPopupWidget(
                    editMode: user.userId == contractEntity.saleId,
                    contract: contractEntity,
                  ),
                ));
      },
      child: const Icon(
        Icons.content_paste,
        color: Colors.blue,
        size: 16,
      ),
    );
  }
}
