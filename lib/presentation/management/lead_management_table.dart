import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/management/lead_management_c.dart';
import 'package:spacefinder/presentation/management/lead_management_table_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/datasource/report_data_source.dart';
import '../../domain/entity/lead_entity.dart';
import '../../l10n/app_l18.dart';

class LeadManagementTable extends StatefulWidget {
  const LeadManagementTable({super.key, required this.leads});

  final List<LeadEntity> leads;

  @override
  State<LeadManagementTable> createState() => _LeadManagementTableState();
}

class _LeadManagementTableState extends State<LeadManagementTable>
    with FormMixin {
  final controller = Get.find<LeadManagementController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _LeadManagementFilterSection(),
            if (controller.hasFilter)
              GestureDetector(
                onTap: () {
                  controller.clearFilter();
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xff2B78A3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: const Text('Xoá tìm kiếm',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff2B78A3)))
                          .paddingSymmetric(vertical: 8)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        buildInput(
            text: Ln.i?.leadIsearchByCode,
            defaultValue: controller.keyword.value,
            isRequired: false,
            onChanged: (keyword) async {
              controller.keyword.value = keyword;
            }),
        Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (controller.leads.isNotEmpty) ...{
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        final reportDataSource = ReportDataSourceImpl();
                        reportDataSource
                            .getAllLeads(widget.leads.first.isDesired ?? false);
                      },
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xff2B78A3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.file_download_outlined,
                                color: Color(0xff2B78A3)),
                            const SizedBox(width: 8),
                            const Text('Xuất Excel',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff2B78A3)))
                                .paddingSymmetric(vertical: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                },
              ],
            )),
        Obx(
          () => controller.isLoading.value
              ? const CircularProgressIndicator()
              : SfDataGrid(
                  source: controller.dataSource,
                  rowHeight: 60,
                  headerRowHeight: 60,
                  columnWidthMode: ColumnWidthMode.auto,
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
                        columnName: 'title',
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Tiêu đề',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'propertyType',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Loại BĐS',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'address',
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Địa chỉ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'price',
                        columnWidthMode: ColumnWidthMode.fill,
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Mức giá (VNĐ)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'createdAt',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Ngày tạo',
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
                        columnName: 'reviewedBy',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Người duyệt/Người tạo',
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
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
              height: 60,
              child: SfDataPager(
                delegate: controller.dataSource,
                pageCount: max(1, controller.leads.length / 4),
                direction: Axis.horizontal,
              )),
        ),
      ],
    );
  }
}

class _LeadManagementFilterSection extends StatelessWidget with FormMixin {
  final controller = Get.find<LeadManagementController>();

  final filterLeadStatuses = [
    'All',
    'Chờ duyệt',
    'Đã duyệt',
    'Đã thuê',
    'Từ chối',
    'Đã đóng'
  ];
  final filterRentalTypes = ['All', 'Dài hạn', 'Ngắn hạn theo đêm'];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 12,
        children: [
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Trạng thái tin đăng',
                value: controller.filterLeadStatus.value,
                values: filterLeadStatuses,
                isRequired: false,
                onSelect: (item) {
                  controller.filterLeadStatus.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Loại BĐS',
                value: controller.filterPropertyType.value,
                values: ['All', ...Constants.default_property_types.names],
                isRequired: false,
                onSelect: (item) {
                  controller.filterPropertyType.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 160,
            child: buildDropdown(
                text: 'Hình thức thuê',
                value: controller.filterRentalType.value,
                values: filterRentalTypes,
                isRequired: false,
                onSelect: (item) {
                  controller.filterRentalType.value = item;
                  controller.fetchData();
                }),
          ),
          SizedBox(
            width: 320,
            child: _buildPriceSlider,
          ),
          SizedBox(
            width: 320,
            child: _buildAreaSlider,
          ),
        ],
      ),
    );
  }

  Widget get _buildPriceSlider => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mức giá',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C))),
          RangeSlider(
            values: RangeValues(controller.filterMinPriceRange.value,
                controller.filterMaxPriceRange.value),
            min: 0,
            max: 50000000,
            divisions: 50,
            labels: RangeLabels(
              controller.filterMinPriceRange.value.round().currencyFormat,
              controller.filterMaxPriceRange.value == 50000000
                  ? '> 50.000.000 VND'
                  : controller.filterMaxPriceRange.value.round().currencyFormat,
            ),
            onChanged: (range) {
              controller.filterMinPriceRange.value = range.start;
              controller.filterMaxPriceRange.value = range.end;
            },
            onChangeEnd: (_) {
              controller.fetchData();
            },
          ),
        ],
      );

  Widget get _buildAreaSlider => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Khoảng diện tích',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C))),
          RangeSlider(
            values: RangeValues(controller.filterMinAreaRange.value,
                controller.filterMaxAreaRange.value),
            min: 0,
            max: 300,
            divisions: 10,
            labels: RangeLabels(
              '${controller.filterMinAreaRange.value.round()}m2',
              controller.filterMaxAreaRange.value == 300
                  ? '> 300m2'
                  : '${controller.filterMaxAreaRange.value.round()}m2',
            ),
            onChanged: (range) {
              controller.filterMinAreaRange.value = range.start;
              controller.filterMaxAreaRange.value = range.end;
            },
            onChangeEnd: (_) {
              controller.fetchData();
            },
          ),
        ],
      );
}
