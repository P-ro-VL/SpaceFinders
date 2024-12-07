import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/common/image/image_upload_section.dart';
import 'package:spacefinder/presentation/contract/contract_management_page.dart';
import 'package:spacefinder/presentation/contract/create_contract_page_c.dart';
import 'package:spacefinder/routes.dart';

class CreateContractPage extends StatefulWidget {
  CreateContractPage({
    super.key,
    this.propertyCode,
    this.rentalType,
  });

  String? propertyCode;
  String? rentalType;

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage>
    with FormMixin {
  final controller = Get.put(CreateContractPageController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Ln.i?.contractIcreatePageTitle ?? '',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff287098),
            )),
        const SizedBox(height: 28),
        Container(
          width: MediaQuery.sizeOf(context).width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Ln.i?.contractIcontractInfo ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0B0B0C),
                  )),
              const SizedBox(height: 24),
              buildInput(
                  text: Ln.i?.contractIpropertyCode,
                  defaultValue: widget.propertyCode ?? '',
                  onChanged: (value) {
                    controller.propertyCode.value = value;
                  }),
              buildInput(
                  text: Ln.i?.contractIvalue,
                  onChanged: (value) {
                    controller.price.value = value;
                  }),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDropdown(
                        text: Ln.i?.contractIrentalType,
                        value: controller.rentalType.value,
                        values: Constants.default_rental_types.names,
                        defaultValue:
                            widget.rentalType ?? controller.rentalType.value,
                        onSelect: (value) {
                          controller.rentalType.value = value;
                        }),
                    buildDropdown(
                        text: Ln.i?.contractIstatus,
                        value: controller.status.value,
                        values: Constants.default_contract_statuses.names,
                        onSelect: (value) {
                          controller.status.value = value;
                        }),
                  ],
                ),
              ),
              buildInput(
                  text: Ln.i?.contractIorderAmount,
                  onChanged: (value) {
                    controller.deposit.value = value;
                  }),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDatePicker(
                        text: Ln.i?.contractIsignedDate,
                        onSelect: (value) =>
                            controller.signedDate.value = value,
                        value: controller.signedDate.value?.ddMMyyyyFormat ??
                            '--'),
                    buildDatePicker(
                        text: Ln.i?.contractIstartDate,
                        onSelect: (value) => controller.startDate.value = value,
                        value:
                            controller.startDate.value?.ddMMyyyyFormat ?? '--'),
                    buildDatePicker(
                        text: Ln.i?.contractIexpiredDate,
                        onSelect: (value) => controller.endDate.value = value,
                        value:
                            controller.endDate.value?.ddMMyyyyFormat ?? '--'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Hợp đồng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0B0B0C),
                  )),
              const SizedBox(height: 8),
              buildUploadSection(
                  text: 'Hình ảnh giấy tờ pháp lý',
                  supportedFiles: ['PDF'],
                  isRequired: true,
                  onSelectImage: (bytes) => controller.bytes = bytes),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Routes.goTo(ContractManagementPage());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xff2B78A3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Huỷ',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff2B78A3))),
                      ),
                    ),
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      await controller.createContract();
                      Routes.goTo(ContractManagementPage());
                      Future.delayed(const Duration(seconds: 2), () {
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.green,
                          title: 'Thành công',
                          message: 'Tạo hợp đồng thành công',
                          duration: Duration(seconds: 2),
                        ));
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff2B78A3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(Ln.i?.contractIcreate ?? '',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      ],
    );
  }
}
