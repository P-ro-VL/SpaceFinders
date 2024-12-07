import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/lead/detail/lead_detail_page_c.dart';
import 'package:spacefinder/presentation/lead/detail/lead_detail_property_section.dart';

import '../../../domain/entity/lead_entity.dart';
import '../../../l10n/app_l18.dart';
import 'lead_detail_contact_w.dart';
import 'lead_detail_image_section.dart';

class LeadDetailPage extends StatefulWidget {
  const LeadDetailPage({super.key, required this.lead});

  final LeadEntity lead;

  @override
  State<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends State<LeadDetailPage> {
  LeadEntity get lead => widget.lead;

  final controller = Get.put(LeadDetailPageController());

  @override
  void initState() {
    controller.lead.value = lead;
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 2 / 3;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(widget.lead.title ?? '',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xff1C2B38),
              )),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.place, size: 14, color: Color(0xff778088)),
              const SizedBox(width: 4),
              Text(
                  '${lead.street != null && lead.street!.isNotEmpty ? '${lead.street!}, ' : ''} ${lead.ward ?? ''}, ${lead.district ?? ''}, ${lead.city ?? ''}')
            ],
          ),
          const SizedBox(height: 16),
          if (lead.status == 'RENTED') ...{
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xff4CAF50),
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Text('Đã Được Thuê',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const SizedBox(height: 12),
          },
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (lead.isDesired == false &&
                          controller.isLoading.value == false) ...{
                        LeadDetailImageSection(images: controller.images),
                        const SizedBox(height: 30),
                      },
                      if (!controller.isLoading.value)
                        LeadDetailPropertySection(),
                      const SizedBox(height: 24),
                      Text(Ln.i?.leadIdetailInfo ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1C2B38),
                          )),
                      const SizedBox(height: 12),
                      Text(lead.description ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      if (lead.requirements != null) ...{
                        const SizedBox(height: 24),
                        Text(Ln.i?.leadInote ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1C2B38),
                            )),
                        const SizedBox(height: 12),
                        Text(lead.requirements ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                      },
                      const SizedBox(height: 24),
                      Text(Ln.i?.leadIrelatedLead ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1C2B38),
                          )),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              LeadDetailContactW(
                lead: widget.lead,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
