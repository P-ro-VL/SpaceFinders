import 'package:flutter/material.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_layout_c.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/lead/step_2/demand_lead_step_2_body.dart';
import 'package:spacefinder/presentation/lead/step_2/for_rent_lead_step_2_body.dart';

class CreateLeadStep2 extends StatelessWidget {
  CreateLeadStep2({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.find<CreateLeadLayoutController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const CircularProgressIndicator()
          : SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                children: [
                  Text(
                    Ln.i?.postIcreate ?? '',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff287098)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    Ln.i?.postIcreateDesc ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4B4B4E)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: FlutterHorizontalStepper(
                        steps: [
                          Ln.i?.postIselectDemand ?? '',
                          Ln.i?.postIrealEstateInfo ?? '',
                          Ln.i?.postIverifyInfo ?? '',
                        ],
                        radius: 45,
                        currentStep: 2,
                        child: const [
                          Text("1",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Text("2",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Text("3",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1))
                        ],
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Form(
                      key: formKey,
                      child: Obx(
                        () => controller.isNeedRentDemand.isTrue
                            ? const DemandLeadStep2Body()
                            : const ForRentLeadStep2Body(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Thông tin chưa đủ hoặc sai sót',
                          message:
                              'Bạn vui lòng kiểm tra lại các thông tin đã nhập.',
                        ));
                        return;
                      }
                      controller.currentStep.value = 3;
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: 44,
                      decoration: BoxDecoration(
                          color: const Color(0xff2B78A3),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          Ln.i?.postInext ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
    );
  }
}
