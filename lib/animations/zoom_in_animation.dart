import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: deprecated_member_use
class ZoomInAnimation extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void onInit() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    controller.forward();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  Widget build({required BuildContext context, required Widget child}) {
    return ScaleTransition(scale: animation, child: child);
  }
}
