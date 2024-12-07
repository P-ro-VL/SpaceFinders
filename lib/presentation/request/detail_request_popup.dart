import 'package:flutter/material.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/domain/entity/request_entity.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';

class DetailRequestPopup extends StatelessWidget with FormMixin {
  DetailRequestPopup({super.key, required this.request});

  final RequestEntity request;

  @override
  Widget build(BuildContext context) {
    final leadValue =
        (request.lead?.code ?? '--') + " - " + (request.lead?.title ?? '--');
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
                value: leadValue,
                values: [leadValue],
                defaultValue: leadValue,
                isDisabled: true,
                onSelect: (item) {}),
            buildDropdown(
                text: 'Loại yêu cầu',
                value: request.requestType,
                values: Constants.default_request_types.names,
                defaultValue: request.requestType ?? '--',
                isDisabled: true,
                onSelect: (item) {}),
            buildInput(
                text: 'Mô tả chi tiết',
                defaultValue: request.requestDetails ?? '--',
                isDisabled: true,
                onChanged: (item) {}),
            Container(
              width: MediaQuery.sizeOf(context).width / 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                width: 200,
                height: 100,
                child: Image.network(request.evidenceFile ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
