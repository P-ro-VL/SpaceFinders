// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_layout_c.dart';

class CreateLeadStep1 extends StatelessWidget {
  CreateLeadStep1({super.key});

  final controller = Get.find<CreateLeadLayoutController>();

  @override
  Widget build(BuildContext context) {
    final halfScreen = MediaQuery.sizeOf(context).width / 2;
    return SizedBox(
      width: halfScreen,
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
                currentStep: 1,
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
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
                border: Border.all(color: Colors.black.withOpacity(0.1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Ln.i?.postIdemand ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B0B0C)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.isNeedRentDemand.value = true;
                            },
                            child: Container(
                              height: 363,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: controller.isNeedRentDemand.isTrue
                                      ? Color(0xff0095B8)
                                      : Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: controller.isNeedRentDemand.isTrue
                                          ? Colors.white
                                          : Color(0xff0095B8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit_document,
                                      color: controller.isNeedRentDemand.isTrue
                                          ? Color(0xff0095B8)
                                          : Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    Ln.i?.postIwantToRent ?? '',
                                    style: TextStyle(
                                        fontSize: 19.4,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            controller.isNeedRentDemand.isFalse
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    Ln.i?.postIwantToRentDesc ?? '',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            controller.isNeedRentDemand.isFalse
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.isNeedRentDemand.value = false;
                            },
                            child: Container(
                              width: 368,
                              height: 363,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: controller.isNeedRentDemand.isFalse
                                      ? Color(0xff0095B8)
                                      : Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: controller.isNeedRentDemand.isFalse
                                          ? Colors.white
                                          : Color(0xff0095B8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.house_outlined,
                                      color: controller.isNeedRentDemand.isFalse
                                          ? Color(0xff0095B8)
                                          : Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    Ln.i?.postIforRent ?? '',
                                    style: TextStyle(
                                        fontSize: 19.4,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            controller.isNeedRentDemand.isTrue
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    Ln.i?.postIforRentDesc ?? '',
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            controller.isNeedRentDemand.isTrue
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    controller.currentStep.value = 2;
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    height: 44,
                    decoration: BoxDecoration(
                        color: Color(0xff2B78A3),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        Ln.i?.postInext ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
