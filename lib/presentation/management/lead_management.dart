import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/management/lead_management_c.dart';
import 'package:spacefinder/presentation/management/lead_management_table.dart';

class LeadManagementPage extends StatefulWidget {
  const LeadManagementPage({super.key, required this.isDemand});

  final bool isDemand;

  @override
  State<LeadManagementPage> createState() => _LeadManagementPageState();
}

class _LeadManagementPageState extends State<LeadManagementPage> {
  late final controller = Get.put(LeadManagementController(widget.isDemand));

  String? get title => !controller.isNeedRentDemand.value
      ? Ln.i?.leadIforRentLeadManagementTitle
      : Ln.i?.leadIneedRentManagementTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 64),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xff287098),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.5))),
              child: LeadManagementTable(leads: controller.leads),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ).paddingSymmetric(horizontal: 32),
      ],
    );
  }
}
