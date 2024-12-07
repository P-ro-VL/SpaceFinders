import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/common/info_ribbon_section.dart';
import 'package:spacefinder/presentation/common/navigation/navigation_bar.dart';
import 'package:spacefinder/presentation/layout_frame_c.dart';

class LayoutFrame extends StatefulWidget {
  const LayoutFrame({super.key});

  @override
  State<LayoutFrame> createState() => _LayoutFrameState();
}

class _LayoutFrameState extends State<LayoutFrame> {
  final controller = Get.find<LayoutFrameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InfoRibbonSection(),
            WebNavigationBar(),
            Obx(() => controller.content.value ?? const SizedBox()),
          ],
        ),
      ),
    );
  }
}
