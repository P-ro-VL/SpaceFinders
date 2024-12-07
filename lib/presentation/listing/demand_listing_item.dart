import 'package:flutter/material.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class DemandListingItem extends StatelessWidget {
  const DemandListingItem({super.key, required this.lead});

  final LeadEntity lead;

  Color get getPropertyTypeColor => switch (lead.propertyType?.toLowerCase()) {
        'chung cư' => const Color(0xff03045E),
        'nhà trọ' => const Color(0xff0077B6),
        'cửa hàng' => const Color(0xff00B4D8),
        'văn phòng' => const Color(0xff0091AE),
        _ => const Color(0xff9CADBC),
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      width: MediaQuery.sizeOf(context).width * 2 / 3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 130,
                    height: 26,
                    decoration: BoxDecoration(
                      color: getPropertyTypeColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(lead.propertyType ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                      height: 14, width: 1, color: const Color(0xffC7CDD0)),
                  const SizedBox(width: 16),
                  Text(
                      '${lead.street != null && lead.street!.isNotEmpty ? '${lead.street!}, ' : ''} ${lead.ward ?? ''}, ${lead.district ?? ''}, ${lead.city ?? ''}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff778088),
                      )),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                lead.title ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(Icons.bed_outlined,
                      size: 30, color: Color(0xff2B2B2B)),
                  Text(lead.numBedrooms?.toString() ?? '--',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff2B2B2B))),
                  Container(
                      height: 14, width: 1, color: const Color(0xffC7CDD0)),
                  const Icon(Icons.shower, size: 30, color: Color(0xff2B2B2B)),
                  Text(lead.numBathrooms?.toString() ?? '--',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff2B2B2B))),
                  Container(
                      height: 14, width: 1, color: const Color(0xffC7CDD0)),
                  const Icon(Icons.aspect_ratio_rounded,
                      size: 30, color: Color(0xff2B2B2B)),
                  Text('${lead.area?.toString() ?? '--'} m2',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff2B2B2B))),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                lead.price == -1
                    ? 'Thoả thuận'
                    : (lead.price ?? 0).currencyFormat,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2B78A3),
                ),
              ),
              Text(
                Ln.i?.postIexpectedPrice ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff778088),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
