import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class LeadDetailImageSection extends StatelessWidget {
  LeadDetailImageSection({super.key, required this.images});

  final List<String> images;

  final selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                if (images.isNotEmpty) ...{
                  Container(
                    height: 460,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      images[selectedIndex.value],
                      fit: BoxFit.cover,
                    ),
                  ),
                } else ...{
                  Container(
                    height: 460,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black26,
                    ),
                  ),
                },
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images
                        .mapIndexed((index, image) => GestureDetector(
                              onTap: () {
                                selectedIndex.value = index;
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  image,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ).marginOnly(right: 8))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
