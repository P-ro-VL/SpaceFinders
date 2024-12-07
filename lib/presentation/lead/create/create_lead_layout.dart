import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_layout_c.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_step_1.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_step_2.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_step_3.dart';

class CreateLeadLayout extends StatefulWidget {
  const CreateLeadLayout({super.key});

  @override
  State<CreateLeadLayout> createState() => _CreateLeadLayoutState();
}

class _CreateLeadLayoutState extends State<CreateLeadLayout> {
  final controller = Get.put(CreateLeadLayoutController());

  @override
  void initState() {
    controller.currentStep.value = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Obx(
            () => switch (controller.currentStep.value) {
              1 => CreateLeadStep1(),
              2 => CreateLeadStep2(),
              3 => CreateLeadStep3(),
              _ => SizedBox(),
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
