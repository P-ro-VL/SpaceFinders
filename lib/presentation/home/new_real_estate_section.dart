import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class NewRealEstateSection extends StatelessWidget {
  const NewRealEstateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (Ln.i?.homeIviewNow ?? '').toUpperCase(),
          style: const TextStyle(
            fontSize: 19.4,
            fontWeight: FontWeight.w500,
            color: Color(0xff0095B8),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              (Ln.i?.homeInewRealEstateList ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 39.8,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          Ln.i?.homeInewRealEstateListDesc ?? '',
          style: const TextStyle(fontSize: 16, color: Color(0xff808080)),
        )
      ],
    ).paddingSymmetric(horizontal: 160);
  }
}
