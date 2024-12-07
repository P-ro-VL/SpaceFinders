import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/home/home_page.dart';

class LayoutFrameController extends GetxController {
  final content = Rxn<Widget>(HomePage());
}
