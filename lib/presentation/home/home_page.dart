import 'package:flutter/material.dart';

import 'about_us_section.dart';
import 'hero_section.dart';
import 'our_service_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [HeroSection(), AboutUsSection(), OurServiceSection()],
    );
  }
}
