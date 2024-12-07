import 'package:flutter/material.dart';

import '../../l10n/app_l18.dart';

class InfoRibbonSection extends StatelessWidget {
  const InfoRibbonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(color: Color(0xff287098)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(
                Icons.place_outlined,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                Ln.i?.address ?? '',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.3,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.phone_enabled_outlined,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(Ln.i?.phone ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.3,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(Ln.i?.email ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.3,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}
