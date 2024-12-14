import 'package:flutter/material.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_layout_c.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_success.dart';
import 'package:spacefinder/routes.dart';

class CreateLeadStep3 extends StatelessWidget {
  CreateLeadStep3({super.key});

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
                        currentStep: 3,
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
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1))
                        ],
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Obx(
                      () => controller.isNeedRentDemand.isTrue
                          ? _buildForm
                          : _buildForRentForm,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await controller.createPost(
                          isNeedRentDemand: controller.isNeedRentDemand.value);
                      Routes.goTo(CreateLeadSuccess());
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Color(0xff2B78A3),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          Ln.i?.postIcreate ?? '',
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

  Widget get _buildForRentForm => Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Ln.i?.postIaddress ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIprovince, text: controller.province.value),
          _buildText(
              title: Ln.i?.postIdistrict, text: controller.district.value),
          _buildText(title: Ln.i?.postIward, text: controller.ward.value),
          _buildText(title: Ln.i?.postIstreet, text: controller.street.value),
          _buildText(title: Ln.i?.postIaddress, text: controller.address.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postIgeneralInfo ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIrealEstateType,
              text: controller.realEstateType.value),
          _buildText(
              title: Ln.i?.postIrentType, text: controller.rentType.value),
          _buildText(
              title: Ln.i?.postIpriceRange,
              text: controller.expectedPrice.value),
          _buildText(
              title: Ln.i?.postIpriceUnit, text: controller.priceUnit.value),
          _buildText(title: Ln.i?.postIarea, text: controller.area.value),
          _buildText(title: Ln.i?.postInote, text: controller.note.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postIdetailInfo ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          if (controller.realEstateType.value != 'Đất nền') ...{
            _buildText(
                title: Ln.i?.postIfurniture, text: controller.furniture.value),
            if (['Nhà trọ', 'Chung cư']
                .contains(controller.realEstateType.value))
              _buildText(
                  title: Ln.i?.postInumOfBedrooms,
                  text: controller.numOfBedrooms),
            _buildText(
                title: Ln.i?.postInumOfBathrooms,
                text: controller.numOfBathrooms),
            _buildText(
                title: Ln.i?.postIhouseDirection,
                text: controller.houseDirection.value),
            _buildText(
                title: Ln.i?.postIbalconyDirection,
                text: controller.balconyDirection.value),
            if (!['Chung cư'].contains(controller.realEstateType.value)) ...{
              _buildText(
                  title: Ln.i?.postImainRoadDist,
                  text: controller.mainRoadDist),
              _buildText(
                  title: Ln.i?.postIfacadeWidth, text: controller.facadeWidth),
            }
          },
          _buildText(
              title: Ln.i?.postInumOfRent, text: controller.numOfRent.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postItitleAndDesc ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIrentPostTitle,
              text: controller.postTitle.value),
          _buildText(
              title: Ln.i?.postIrentPostDesc,
              text: controller.postDescription.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postIimage ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Wrap(
            spacing: 8,
            children: controller.cachedImages
                .map((e) => Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black26)),
                      child: Image.memory(
                        e,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.article,
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ));

  Widget get _buildForm => Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Ln.i?.postIaddress ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          _buildText(
              title: Ln.i?.postIprovince, text: controller.province.value),
          _buildText(
              title: Ln.i?.postIdistrict, text: controller.district.value),
          _buildText(title: Ln.i?.postIward, text: controller.ward.value),
          _buildText(title: Ln.i?.postIstreet, text: controller.street.value),
          _buildText(
              title: Ln.i?.postIdisplayAddress, text: controller.address.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postIgeneralInfo ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIrealEstateType,
              text: controller.realEstateType.value),
          _buildText(
              title: Ln.i?.postIrentType, text: controller.rentType.value),
          _buildText(
              title: Ln.i?.postIpriceRange,
              text: controller.expectedPrice.value),
          _buildText(
              title: Ln.i?.postIpriceUnit, text: controller.priceUnit.value),
          _buildText(title: Ln.i?.postIarea, text: controller.area.value),
          _buildText(title: Ln.i?.postInote, text: controller.note.value),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postIdetailInfo ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIfurniture, text: controller.furniture.value),
          _buildText(
              title: Ln.i?.postInumOfBedrooms, text: controller.numOfBedrooms),
          _buildText(
              title: Ln.i?.postInumOfBathrooms,
              text: controller.numOfBathrooms),
          _buildText(
              title: Ln.i?.postIhouseDirection,
              text: controller.houseDirection.value),
          _buildText(
              title: Ln.i?.postIbalconyDirection,
              text: controller.balconyDirection.value),
          _buildText(
              title: Ln.i?.postImainRoadDist, text: controller.mainRoadDist),
          _buildText(
              title: Ln.i?.postIfacadeWidth, text: controller.facadeWidth),
          const SizedBox(height: 24),
          Text(
            Ln.i?.postItitleAndDesc ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildText(
              title: Ln.i?.postIrentPostTitle,
              text: controller.postTitle.value),
          _buildText(
              title: Ln.i?.postIrentPostDesc,
              text: controller.postDescription.value),
        ],
      ));

  Widget _buildText({required String? title, required String? text}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              (text ?? '').isEmpty ? '--' : text!,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      );
}
