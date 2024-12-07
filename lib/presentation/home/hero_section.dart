import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/home_background.svg",
          width: MediaQuery.sizeOf(context).width,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildLeftSection, _buildRightSection],
            ).paddingSymmetric(horizontal: 160).marginOnly(top: 90),
            Center(
              child: Image.asset(
                "assets/images/home_info.png",
                height: 100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _buildLeftSection => SizedBox(
        width: 580,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (Ln.i?.homeIrealEstate ?? '').toUpperCase(),
              style: const TextStyle(
                fontSize: 19.4,
                letterSpacing: 8,
                fontWeight: FontWeight.w700,
                color: Color(0xff0095B8),
              ),
            ),
            Text(
              Ln.i?.homeIexplorePerfectSpace ?? '',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: Color(0xff0B090A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              Ln.i?.homeIexplorePerfectSpaceDesc ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff808080),
              ),
            ),
            const SizedBox(height: 24),
            Image.asset("assets/images/example_house_1.png"),
          ],
        ),
      );

  Widget get _buildRightSection => Container(
        width: 420,
        height: 582,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/home_form.png',
            fit: BoxFit.cover,
          ),
        ),
      );
}
