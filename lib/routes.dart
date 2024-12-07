import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/presentation/home/home_page.dart';
import 'package:spacefinder/presentation/layout_frame_c.dart';

class Routes {
  static Stack<Widget> routeHistory = Stack();
  static Widget currentRoute = HomePage();

  static void goTo(Widget page) {
    final controller = Get.find<LayoutFrameController>();
    Get.deleteAll();
    controller.content.value = page;
    routeHistory.push(currentRoute);
    currentRoute = page;
  }

  static void back() {
    final last = routeHistory.pop();
    if (last == null) return;
    goTo(last);
  }
}

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E? pop() => (isEmpty) ? null : _list.removeLast();

  E? get peek => (isEmpty) ? null : _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
