import 'package:flutter/material.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class OurServiceSection extends StatelessWidget {
  const OurServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 752,
      decoration: const BoxDecoration(
        color: Color(0xffD4D4D4),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (Ln.i?.homeIourService ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
                color: Color(0xff2b2b2b),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              (Ln.i?.homeIweSupplyService ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 39.8,
                fontWeight: FontWeight.w600,
                color: Color(0xff0B090A),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                    title: Ln.i?.homeIfindRealEstate,
                    description: Ln.i?.homeIfindRealEstateDesc,
                    icon: Icons.search_outlined),
                const SizedBox(width: 32),
                _buildCard(
                    title: Ln.i?.homeIpostRentNews,
                    description: Ln.i?.homeIpostRentNewsDesc,
                    icon: Icons.home_outlined),
                const SizedBox(width: 32),
                _buildCard(
                    title: Ln.i?.homeIpostNeedRentNews,
                    description: Ln.i?.homeIpostNeedRentNewsDesc,
                    icon: Icons.bed_outlined),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String? title,
    required String? description,
    required IconData? icon,
  }) {
    return Container(
      width: 340,
      height: 363,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 8,
                offset: Offset.zero,
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
                color: Color(0xff0095B8), shape: BoxShape.circle),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19.4,
              fontWeight: FontWeight.w700,
              color: Color(0xff2B2B2B),
            ),
          ),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff2B2B2B),
            ),
          )
        ],
      ),
    );
  }
}
