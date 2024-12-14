import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/utils/random_picker.dart';

import '../../routes.dart';
import '../lead/detail/lead_detail_page.dart';
import 'demand_listing_item.dart';
import 'listing_item.dart';
import 'listing_page_c.dart';

class LeadListingPage extends StatelessWidget {
  LeadListingPage({super.key, required this.isDemand});

  final bool isDemand;

  late final controller = Get.put(LeadListingPageController(isDemand));

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const CircularProgressIndicator()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.start,
                  runSpacing: 32,
                  spacing: 32,
                  children: controller.leads.isEmpty
                      ? [
                          const Center(
                            child: Text('Không có kết quả phù hợp'),
                          )
                        ]
                      : controller.leads
                          .map((e) => GestureDetector(
                                onTap: () {
                                  Routes.goTo(LeadDetailPage(
                                      lead: e,
                                      relatingLeads:
                                          controller.leads.pickRandomItems(5)));
                                },
                                child: isDemand && e.isDesired == isDemand
                                    ? DemandListingItem(lead: e)
                                    : LeadListingItem(lead: e),
                              ))
                          .toList(),
                )),
                const SizedBox(width: 16),
                Obx(
                  () => SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Filter',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Địa chỉ',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        _buildDropdown(
                            text: Ln.i?.postIprovince,
                            value: controller.province.value,
                            values: controller.provinces,
                            onSelect: (item) async {
                              controller.province.value = item;
                              controller.provinceId =
                                  Constants.getProvinceId(item).toInt();

                              controller.districts.clear();
                              await controller.loadDistricts();
                              controller.district.value =
                                  controller.districts.first;
                              controller.districtId = Constants.getDistrictId(
                                      controller.provinceId,
                                      controller.district.value)
                                  .toInt();

                              controller.fetchData();
                            }),
                        _buildDropdown(
                            text: Ln.i?.postIdistrict,
                            value: controller.district.value,
                            values: ['All', ...controller.districts],
                            onSelect: (item) {
                              controller.district.value = item;
                              controller.districtId = Constants.getDistrictId(
                                      controller.provinceId, item)
                                  .toInt();

                              controller.fetchData();
                            }),
                        const SizedBox(height: 16),
                        Text(
                          Ln.i?.postIrealEstateType ?? '',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          'All',
                          ...Constants.default_property_types.names
                        ].map((e) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: const Color(0xff2B78A3),
                            title: Text(
                              e,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.propertyType.value == e
                                    ? const Color(0xff2B78A3)
                                    : Colors.black87,
                              ),
                            ),
                            value: controller.propertyType.value == e,
                            onChanged: (item) {
                              if (item == true) {
                                controller.propertyType.value = e;
                                controller.fetchData();
                              }
                            })),
                        const SizedBox(height: 22),
                        Text(
                          Ln.i?.postIpriceRange ?? '',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 14),
                        RangeSlider(
                          values: RangeValues(controller.minPrice.value,
                              controller.maxPrice.value),
                          min: 1000000,
                          max: 50000000,
                          divisions: 49,
                          labels: RangeLabels(
                            controller.minPrice.value == 1000000
                                ? 'Dưới 1.000.000 VNĐ'
                                : controller.minPrice.value
                                    .round()
                                    .currencyFormat,
                            controller.maxPrice.value != 50000000
                                ? controller.maxPrice.value
                                    .round()
                                    .currencyFormat
                                : "Trên 50.000.000 VNĐ",
                          ),
                          onChanged: (range) {
                            controller.minPrice.value = range.start;
                            controller.maxPrice.value = range.end;
                          },
                          onChangeEnd: (_) {
                            controller.fetchData();
                          },
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('< 1.000.000VNĐ',
                                style: TextStyle(fontSize: 14)),
                            Text('> 50.000.000VNĐ',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          Ln.i?.postIrentType ?? '',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 14),
                        ...[
                          ChoiceItem(code: 'All', name: 'All'),
                          ...Constants.default_rental_types
                        ].map((e) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: const Color(0xff2B78A3),
                            title: Text(
                              e.name ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.rentalType.value == e.name
                                    ? const Color(0xff2B78A3)
                                    : Colors.black87,
                              ),
                            ),
                            value: controller.rentalType.value == e.name,
                            onChanged: (item) {
                              if (item == true && e.name != 'All') {
                                controller.rentalType.value = e.name;
                                controller.fetchData();
                              } else {
                                controller.rentalType.value = null;
                                controller.fetchData();
                              }
                            })),
                      ],
                    ),
                  ),
                )
              ],
            ),
    ).paddingSymmetric(horizontal: 32).marginOnly(top: 32);
  }

  Widget _buildDropdown(
      {required String? text,
      required String? value,
      required List<String> values,
      required Function(dynamic) onSelect}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField(
          value: value,
          items: values
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: onSelect,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
