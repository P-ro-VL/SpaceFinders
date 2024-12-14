import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';
import 'package:spacefinder/presentation/contract/detail_contract_popup_c.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../domain/entity/contract_entity.dart';
import '../../l10n/app_l18.dart';

class DetailContractPopupWidget extends StatefulWidget {
  const DetailContractPopupWidget(
      {super.key, required this.editMode, required this.contract});

  final bool editMode;
  final ContractEntity contract;

  @override
  State<DetailContractPopupWidget> createState() =>
      _DetailContractPopupWidgetState();
}

class _DetailContractPopupWidgetState extends State<DetailContractPopupWidget>
    with FormMixin {
  final controller = Get.put(DetailContractPopupController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 500,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hợp đồng cho thuê bất động sản',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),
            const Text('Thông tin hợp đồng',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            buildInput(
                text: Ln.i?.contractIpropertyCode,
                isDisabled: true,
                defaultValue: widget.contract.code ?? '--',
                onChanged: (item) {}),
            buildInput(
                text: Ln.i?.contractIvalue,
                isDisabled: true,
                defaultValue: (widget.contract.rentalPrice ?? 0).currencyFormat,
                onChanged: (item) {}),
            buildInput(
                text: Ln.i?.contractIrentalType,
                isDisabled: true,
                defaultValue: widget.contract.rentalType ?? '--',
                onChanged: (item) {}),
            buildDropdown(
                isDisabled: !widget.editMode,
                text: Ln.i?.contractIstatus,
                value: controller.selectedContractStatus.value,
                values: Constants.default_contract_statuses.names,
                onSelect: (item) {}),
            buildInput(
                text: Ln.i?.contractIorderAmount,
                isDisabled: true,
                defaultValue:
                    (widget.contract.depositAmount ?? 0).currencyFormat,
                onChanged: (item) {}),
            buildInput(
                text: 'Giá trị hoa hồng',
                isDisabled: true,
                defaultValue: ((widget.contract.rentalPrice ?? 1) *
                        (widget.contract.rentalType == 'Dài hạn' ? 0.08 : 0.1))
                    .currencyFormat,
                onChanged: (item) {}),
            buildInput(
                text: Ln.i?.contractIsignedDate,
                isDisabled: true,
                defaultValue: widget.contract.signDate?.ddMMyyyyFormat ?? '--',
                onChanged: (item) {}),
            buildInput(
                text: Ln.i?.contractIexpiredDate,
                isDisabled: true,
                defaultValue: widget.contract.endDate?.ddMMyyyyFormat ?? '--',
                onChanged: (item) {}),
            const SizedBox(height: 12),
            const Text('Thông tin hợp đồng',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            buildClickableInput(
                text: Ln.i?.contractIlegalInfoProof,
                defaultValue: 'Nhấn để xem chi tiết giấy tờ pháp lý',
                isDisabled: true,
                onClick: () async {
                  final url = Supabase.instance.client.storage
                      .from('spacefinder-cdn')
                      .getPublicUrl((widget.contract.url ?? '')
                          .replaceAll("spacefinder-cdn/", ""));
                  launchUrlString(url);
                }),
            if (widget.editMode) ...{
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xff2B78A3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Text('Huỷ',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff2B78A3)))),
                    ),
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff2B78A3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Text('Xác nhận',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white))),
                    ),
                  )),
                ],
              ),
            }
          ],
        ),
      ),
    );
  }
}
