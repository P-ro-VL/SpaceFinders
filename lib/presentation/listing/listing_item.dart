import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/usecase/lead/get_lead_images_use_case.dart';

import '../../domain/entity/lead_entity.dart';

class LeadListingItem extends StatefulWidget {
  const LeadListingItem({super.key, required this.lead});

  final LeadEntity lead;

  @override
  State<LeadListingItem> createState() => _LeadListingItemState();
}

class _LeadListingItemState extends State<LeadListingItem> {
  final isLoading = true.obs;
  final images = [];

  LeadEntity get lead => widget.lead;

  @override
  void initState() {
    final getAllLeadImages =
        GetLeadImagesUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
    getAllLeadImages.call(lead.leadId ?? -1).then((response) {
      isLoading.value = false;
      images.addAll(response.right);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: isLoading.value
                    ? const CircularProgressIndicator()
                    : Image.network(
                        images.firstOrNull ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                            child: Text(
                          'Chưa cập nhật',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    lead.price == -1
                        ? 'Thoả thuận'
                        : (lead.price ?? 0).currencyFormat,
                    style: const TextStyle(
                        fontSize: 27,
                        color: Color(0xff287098),
                        fontWeight: FontWeight.bold)),
                Text('${lead.area ?? '--'}m2',
                    style: const TextStyle(
                        fontSize: 27,
                        color: Color(0xff287098),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lead.title ?? '--',
              style:
                  const TextStyle(fontSize: 19.4, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '${lead.ward ?? ''}, ${lead.district ?? ''}, ${lead.city ?? ''}',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff808080),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bed,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(lead.numBedrooms?.toString() ?? '--')
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.shower,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(lead.numBathrooms?.toString() ?? '--')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
