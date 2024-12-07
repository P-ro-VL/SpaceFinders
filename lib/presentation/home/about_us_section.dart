import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLeftSection,
        _buildRightSection,
      ],
    ).paddingSymmetric(horizontal: 160);
  }

  Widget get _buildLeftSection => SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (Ln.i?.homeIaboutUs ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
                color: Color(0xff0095B8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              (Ln.i?.homeIensureFindable ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 39.8,
                fontWeight: FontWeight.w400,
                color: Color(0xff2B2B2B),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              (Ln.i?.homeIensureFindableDesc ?? ''),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff808080),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/images/home_about_us_1.png",
              width: 400,
            ),
            Image.asset(
              "assets/images/home_about_us_2.png",
              width: 400,
            ),
          ],
        ),
      );

  Widget get _buildRightSection => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/images/example_house_2.png"),
            ],
          ),
          Column(
            children: [
              Image.asset("assets/images/example_house_3.png"),
              Image.asset("assets/images/example_house_4.png"),
            ],
          ),
        ],
      );
}
