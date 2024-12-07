import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/request/create_request_popup_c.dart';

import '../lead/history/lead_history_page_c.dart';

class CreateRequestPopup extends StatelessWidget with FormMixin {
  CreateRequestPopup({super.key});

  final controller = Get.put(CreateRequestPopupController());

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Yêu cầu hỗ trợ thay đổi tin đăng sau duyệt',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),
            buildDropdown(
                text: 'Mã tin đăng',
                value: controller.selectedLeadOption.value,
                values: controller.leadOptions,
                onSelect: (item) {
                  controller.leadId = Get.find<LeadHistoryPageController>()
                          .leads
                          .firstWhereOrNull((e) =>
                              ((e.code ?? '--') + " - " + (e.title ?? '--')) ==
                              item)
                          ?.leadId ??
                      -1;
                  controller.postCode.value = item;
                }),
            buildDropdown(
                text: 'Loại yêu cầu',
                value: controller.selectedRequestType.value,
                values: Constants.default_request_types.names,
                onSelect: (item) =>
                    controller.selectedRequestType.value = item),
            buildInput(
                text: 'Mô tả chi tiết',
                onChanged: (item) => controller.description.value = item),
            buildUploadSection(
                text: 'Minh chứng đính kèm',
                supportedFiles: ['JPEG', 'JPG', 'PNG'],
                onSelectImage: (bytes) {
                  controller.selectedFile = bytes;
                }),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xff2B78A3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: const Text('Huỷ',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff2B78A3)))
                            .paddingSymmetric(vertical: 8)),
                  ),
                )),
                const SizedBox(width: 8),
                Expanded(
                    child: GestureDetector(
                        onTap: () async {
                          final result = await controller.createRequest();
                          Get.back();
                          if (result) {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.green,
                              title: 'Tạo yêu cầu',
                              message:
                                  'Tạo yêu cầu thành công. Yêu cầu của bạn đang chờ xét duyệt.',
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              title: 'Tạo yêu cầu',
                              message:
                                  'Tạo yêu cầu thất bại. Vui lòng thử lại sau.',
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff2B78A3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: const Text('Gửi',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white))
                                  .paddingSymmetric(vertical: 8)),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
