import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';

import '../../../constants.dart';
import '../../../l10n/app_l18.dart';
import '../../../utils/currency_input_formatter.dart';
import '../create/create_lead_layout_c.dart';

class ForRentLeadStep2Body extends StatefulWidget {
  const ForRentLeadStep2Body({super.key});

  @override
  State<ForRentLeadStep2Body> createState() => _ForRentLeadStep2BodyState();
}

class _ForRentLeadStep2BodyState extends State<ForRentLeadStep2Body>
    with FormMixin {
  final controller = Get.find<CreateLeadLayoutController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Ln.i?.postIaddress ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(
                text: Ln.i?.postIprovince,
                value: controller.province.value,
                values: controller.provinces,
                onSelect: (item) async {
                  controller.province.value = item;
                  controller.provinceId = Constants.getProvinceId(item).toInt();

                  controller.district.value = '';
                  controller.ward.value = '';
                  controller.districts.clear();
                  controller.wards.clear();
                  await controller.loadDistricts();
                  controller.districtId = Constants.getDistrictId(
                          controller.provinceId, controller.district.value!)
                      .toInt();
                  await controller.loadWards();
                },
              ),
              buildDropdown(
                text: Ln.i?.postIdistrict,
                value: controller.district.value,
                values: controller.districts,
                onSelect: (item) {
                  controller.district.value = item;
                  controller.districtId =
                      Constants.getDistrictId(controller.provinceId, item)
                          .toInt();

                  controller.ward.value = '';
                  controller.wards.clear();
                  controller.loadWards();
                },
              ),
              buildDropdown(
                text: Ln.i?.postIward,
                value: controller.ward.value,
                values: controller.wards,
                onSelect: (item) => controller.ward.value = item,
              ),
            ],
          ),
        ),
        buildInput(
          text: Ln.i?.postIstreet,
          onChanged: (item) => controller.street.value = item,
          isRequired: false,
        ),
        buildInput(
          text: Ln.i?.postIaddress,
          onChanged: (item) => controller.address.value = item,
          isRequired: false,
        ),
        Text(
          Ln.i?.postIgeneralInfo ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        buildDropdown(
          text: Ln.i?.postIrealEstateType,
          value: controller.realEstateType.value,
          values: controller.realEstateTypes,
          onSelect: (type) => controller.realEstateType.value = type,
        ),
        buildDropdown(
          text: Ln.i?.postIrentType,
          value: controller.rentType.value,
          values: controller.rentTypes,
          onSelect: (item) => controller.rentType.value = item,
        ),
        Obx(
          () => buildInput(
            text: Ln.i?.postIpriceRange,
            onChanged: (value) => controller.expectedPrice.value = value,
            isDisabled: controller.priceUnit.value == 'Thoả thuận',
            formatter: CurrencyInputFormatter(),
            note:
                'Dài hạn hiểu là giá thuê 1 tháng, Ngắn hạn theo đêm hiểu là giá thuê 1 đêm',
          ),
        ),
        buildDropdown(
          text: Ln.i?.postIpriceUnit,
          value: controller.priceUnit.value,
          values: controller.priceUnits,
          onSelect: (item) => controller.priceUnit.value = item,
        ),
        buildInput(
          text: Ln.i?.postIarea,
          onChanged: (value) => controller.area.value = value,
        ),
        buildInput(
          text: Ln.i?.postInote,
          onChanged: (value) => controller.note.value = value,
          isRequired: false,
        ),
        Text(
          Ln.i?.postIdetailInfo ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        buildDropdown(
            text: Ln.i?.postIlegalInfo,
            value: controller.legalInfo.value,
            values: controller.legalInfos,
            onSelect: (item) {
              controller.legalInfo.value = item;
            }),
        buildUploadSection(
            text: 'Minh chứng giấy tờ pháp lý', supportedFiles: ['PDF']),
        Obx(
          () => Column(
            children: (controller.realEstateType.value != 'Đất nền')
                ? [
                    buildDropdown(
                      text: Ln.i?.postIfurniture,
                      value: controller.furniture.value,
                      values: controller.furnitures,
                      onSelect: (item) => controller.furniture.value = item,
                      isRequired: false,
                    ),
                    if (['Nhà trọ', 'Chung cư']
                        .contains(controller.realEstateType.value))
                      buildInput(
                        text: Ln.i?.postInumOfBedrooms,
                        defaultValue: controller.numOfBedrooms,
                        onChanged: (value) => controller.numOfBedrooms = value,
                        isRequired: false,
                      ),
                    buildInput(
                      text: Ln.i?.postInumOfBathrooms,
                      defaultValue: controller.numOfBathrooms,
                      onChanged: (value) => controller.numOfBathrooms = value,
                      isRequired: false,
                    ),
                    buildDropdown(
                      text: Ln.i?.postIhouseDirection,
                      value: controller.houseDirection.value,
                      values: controller.directions,
                      onSelect: (item) =>
                          controller.houseDirection.value = item,
                      isRequired: false,
                    ),
                    buildDropdown(
                      text: Ln.i?.postIbalconyDirection,
                      value: controller.balconyDirection.value,
                      values: controller.directions,
                      onSelect: (item) =>
                          controller.balconyDirection.value = item,
                      isRequired: false,
                    ),
                    if (!['Chung cư']
                        .contains(controller.realEstateType.value)) ...{
                      buildInput(
                        text: Ln.i?.postImainRoadDist,
                        defaultValue: controller.mainRoadDist,
                        onChanged: (value) => controller.mainRoadDist = value,
                        isRequired: false,
                      ),
                      buildInput(
                        text: Ln.i?.postIfacadeWidth,
                        defaultValue: controller.facadeWidth,
                        onChanged: (value) => controller.facadeWidth = value,
                        isRequired: false,
                      ),
                    }
                  ]
                : [SizedBox()],
          ),
        ),
        Text(
          Ln.i?.postItitleAndDesc ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        buildInput(
          text: Ln.i?.postIrentPostTitle,
          onChanged: (value) => controller.postTitle.value = value,
        ),
        buildTextArea(
          text: Ln.i?.postIrentPostDesc,
          onChanged: (value) => controller.postDescription.value = value,
        ),
        Text(
          Ln.i?.postIimage ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        buildUploadSection(
            text: 'Hình ảnh mô tả về bất động sản',
            minImage: 3,
            otherNote: 'Không chèn số điện thoại',
            supportedFiles: ['JPEG', 'JPG', 'PNG'],
            onSelectImage: (bytes) {
              controller.upload(bytes);
            }),
      ],
    );
  }
}
