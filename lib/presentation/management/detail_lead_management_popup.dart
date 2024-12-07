import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/management/detail_lead_management_popup_c.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailLeadManagementPopup extends StatefulWidget {
  const DetailLeadManagementPopup(
      {super.key, required this.lead, required this.isEdit});

  final LeadEntity lead;
  final bool isEdit;

  @override
  State<DetailLeadManagementPopup> createState() =>
      _DetailLeadManagementPopupState();
}

class _DetailLeadManagementPopupState extends State<DetailLeadManagementPopup>
    with FormMixin {
  final controller = Get.put(DetailLeadManagementPopupController());

  @override
  void initState() {
    controller.lead.value = widget.lead;
    controller.prefill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 1500,
        height: 800,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Ln.i?.leadIdetailLead ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0B0B0C),
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.black45,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Ln.i?.leadIaddress ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                  _buildInput(
                                      text: Ln.i?.postIdisplayAddress,
                                      controller: controller.addressController,
                                      onChanged: (value) {
                                        controller.addressController.text =
                                            value;
                                      }),
                                ],
                              ),
                            ).marginOnly(bottom: 12),
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Ln.i?.postIgeneralInfo ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                  _buildInput(
                                      text: Ln.i?.postIforRentLeadCode,
                                      controller: controller.leadCodeController,
                                      isDisabled: true,
                                      onChanged: (value) {}),
                                  Row(children: [
                                    Expanded(
                                      child: _buildDropdown(
                                        text: Ln.i?.postIrealEstateType,
                                        value: controller.realEstateType.value,
                                        values: Constants
                                            .default_property_types.names,
                                        onSelect: (item) => controller
                                            .realEstateType.value = item,
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDropdown(
                                        text: Ln.i?.postIrentType,
                                        value: controller.rentType.value,
                                        values: Constants
                                            .default_rental_types.names,
                                        onSelect: (item) =>
                                            controller.rentType.value = item,
                                      ),
                                    ),
                                  ]),
                                  Row(children: [
                                    Expanded(
                                      child: _buildInput(
                                          text: Ln.i?.postIpriceRange,
                                          controller:
                                              controller.priceController,
                                          onChanged: (value) {
                                            controller.priceController.text =
                                                value;
                                          }),
                                    ),
                                    Expanded(
                                      child: _buildDropdown(
                                        text: Ln.i?.postIpriceUnit,
                                        value: controller.priceUnit.value,
                                        values: ['VNĐ'],
                                        onSelect: (item) =>
                                            controller.priceUnit.value = item,
                                      ),
                                    ),
                                  ]),
                                  _buildInput(
                                      text: Ln.i?.postIarea,
                                      controller: controller.areaController,
                                      onChanged: (value) {
                                        controller.areaController.text = value;
                                      }),
                                  _buildInput(
                                      text: Ln.i?.postInote,
                                      controller: controller.noteController,
                                      isRequired: false,
                                      onChanged: (value) {
                                        controller.noteController.text = value;
                                      }),
                                ],
                              ),
                            ).marginOnly(bottom: 12),
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Ln.i?.postItitleAndDesc ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                  _buildInput(
                                      text: Ln.i?.postIrentPostTitle,
                                      controller: controller.titleController,
                                      onChanged: (value) {
                                        controller.titleController.text = value;
                                      }),
                                  _buildInput(
                                      text: Ln.i?.postIrentPostDesc,
                                      controller:
                                          controller.descriptionController,
                                      onChanged: (value) {
                                        controller.descriptionController.text =
                                            value;
                                      }),
                                ],
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Ln.i?.postIdetailInfo ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                  if (controller.lead.value?.isDesired ==
                                      false) ...{
                                    _buildDropdown(
                                      text: Ln.i?.postIlegalInfo,
                                      value: controller.legalInfo.value,
                                      values:
                                          Constants.default_legal_infos.names,
                                      isRequired: false,
                                      onSelect: (item) =>
                                          controller.legalInfo.value = item,
                                    ),
                                    buildClickableInput(
                                        text: 'Minh chứng giấy tờ pháp lý',
                                        isDisabled: true,
                                        defaultValue: 'Nhấn để xem minh chứng',
                                        onClick: () {
                                          launchUrlString(controller.proof);
                                        }),
                                  },
                                  _buildDropdown(
                                    text: Ln.i?.postIfurniture,
                                    value: controller.furniture.value,
                                    values: Constants.default_furnishing.names,
                                    isRequired: false,
                                    onSelect: (item) =>
                                        controller.furniture.value = item,
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: _buildInput(
                                          controller:
                                              controller.numOfBedroomController,
                                          text: Ln.i?.postInumOfBedrooms,
                                          isRequired: false,
                                          onChanged: (value) {
                                            controller.numOfBedroomController
                                                .text = value;
                                          }),
                                    ),
                                    Expanded(
                                      child: _buildInput(
                                          controller: controller
                                              .numOfBathroomController,
                                          text: Ln.i?.postInumOfBathrooms,
                                          isRequired: false,
                                          onChanged: (value) {
                                            controller.numOfBathroomController
                                                .text = value;
                                          }),
                                    ),
                                  ]),
                                  Row(children: [
                                    Expanded(
                                      child: _buildDropdown(
                                        text: Ln.i?.postIhouseDirection,
                                        value:
                                            controller.housingDirection.value,
                                        values:
                                            Constants.default_directions.names,
                                        isRequired: false,
                                        onSelect: (item) => controller
                                            .housingDirection.value = item,
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDropdown(
                                        text: Ln.i?.postIbalconyDirection,
                                        value:
                                            controller.balconyDirection.value,
                                        values:
                                            Constants.default_directions.names,
                                        isRequired: false,
                                        onSelect: (item) => controller
                                            .balconyDirection.value = item,
                                      ),
                                    ),
                                  ]),
                                  _buildInput(
                                      controller:
                                          controller.mainRoadDistController,
                                      text: Ln.i?.postImainRoadDist,
                                      isRequired: false,
                                      onChanged: (value) {
                                        controller.mainRoadDistController.text =
                                            value;
                                      }),
                                  _buildInput(
                                      controller:
                                          controller.facadeWidthController,
                                      text: Ln.i?.postIfacadeWidth,
                                      isRequired: false,
                                      onChanged: (value) {
                                        controller.facadeWidthController.text =
                                            value;
                                      }),
                                ],
                              ),
                            ).marginOnly(bottom: 12),
                            if (controller.lead.value?.isDesired == false) ...{
                              Text(Ln.i?.postIimage ?? '',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff333333))),
                              Row(
                                children: controller.images
                                    .map((e) => Container(
                                          width: 150,
                                          height: 150,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.black26)),
                                          child: Image.network(e),
                                        ))
                                    .toList(),
                              )
                            },
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (widget.isEdit)
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xff287098)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text('Huỷ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff287098))),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff287098),
                                  border: Border.all(
                                      color: const Color(0xff287098)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text('Chỉnh sửa',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ).paddingAll(32),
              ),
      ),
    );
  }

  Widget _buildInput(
      {required String? text,
      required Function(dynamic) onChanged,
      required TextEditingController controller,
      bool isRequired = true,
      bool? isDisabled}) {
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
            if (isRequired)
              const Text(' (*)',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabled: widget.isEdit || !(isDisabled ?? true),
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildClickableInput({
    required String? text,
    required Function() onClick,
    bool isDisabled = false,
    bool isRequired = true,
    bool isUrl = true,
    String? note,
    String? defaultValue,
  }) {
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
            const Text(' *',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
            decoration: InputDecoration(
              enabled: !isDisabled,
              border: OutlineInputBorder(),
            ),
            onTap: onClick,
            controller: TextEditingController(text: defaultValue ?? ''),
            validator: (s) {
              if (!isRequired) return null;
              if (s == null || s.isEmpty) {
                return 'Đây là thông tin bắt buộc, vui lòng bổ sung';
              }
            },
            style: isUrl
                ? const TextStyle(
                    color: Color(0xff1253F6),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff1253F6))
                : null),
        if (note != null) ...{
          const SizedBox(
            height: 4,
          ),
          Text(note,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff93939B),
              )),
        },
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buildDropdown(
      {required String? text,
      required String? value,
      required List<String> values,
      required Function(dynamic) onSelect,
      bool isRequired = true}) {
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
            if (isRequired)
              const Text(' (*)',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
          ],
        ),
        const SizedBox(height: 4),
        IgnorePointer(
          ignoring: widget.isEdit == false,
          child: DropdownButtonFormField(
            value: value,
            items: values
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              enabled: widget.isEdit,
            ),
            onChanged: onSelect,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
