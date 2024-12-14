import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/presentation/lead/detail/lead_detail_page_c.dart';
import 'package:spacefinder/presentation/lead/detail/lead_detail_property_w.dart';

class LeadDetailPropertySection extends StatelessWidget {
  LeadDetailPropertySection({super.key});

  final controller = Get.find<LeadDetailPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        border: Border.all(color: const Color(0xff16527D).withOpacity(0.08)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeadDetailPropertyW(
                  icon: Icons.sell,
                  title: 'Mức giá mong muốn',
                  value: (controller.lead.value?.price ?? 0).currencyFormat),
              LeadDetailPropertyW(
                  icon: Icons.aspect_ratio_outlined,
                  title: 'Diện tích mong muốn',
                  value: '${controller.lead.value?.area ?? '--'} m2'),
              LeadDetailPropertyW(
                  icon: Icons.interests,
                  title: 'Loại Bất động sản',
                  value: controller.lead.value?.propertyType ?? '--'),
              LeadDetailPropertyW(
                  icon: Icons.edit_document,
                  title: 'Hình thức thuê',
                  value: controller.lead.value?.rentalType ?? '--'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeadDetailPropertyW(
                  icon: Icons.bed,
                  title: 'Số phòng ngủ',
                  value:
                      controller.lead.value?.numBedrooms?.toString() ?? '--'),
              LeadDetailPropertyW(
                  icon: Icons.shower,
                  title: 'Số phòng tắm, vệ sinh',
                  value:
                      controller.lead.value?.numBathrooms?.toString() ?? '--'),
              LeadDetailPropertyW(
                  icon: Icons.chair,
                  title: 'Nội thất',
                  value: controller.lead.value?.furnishing ?? '--'),
              LeadDetailPropertyW(
                  icon: Icons.explore,
                  title: 'Hướng nhà',
                  value: controller.lead.value?.houseDirection ?? '--'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeadDetailPropertyW(
                  icon: Icons.balcony,
                  title: 'Hướng ban công',
                  value: controller.lead.value?.balconyDirection ?? '--'),
              LeadDetailPropertyW(
                  icon: Icons.signpost,
                  title: 'Đường vào',
                  value:
                      '${controller.lead.value?.entranceWidth?.toString() ?? '--'}m'),
              LeadDetailPropertyW(
                  icon: Icons.door_front_door,
                  title: 'Mặt tiền',
                  value:
                      '${controller.lead.value?.frontWidth?.toString() ?? '--'}m'),
            ],
          ),
        ],
      ),
    );
  }
}
