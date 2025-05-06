import 'package:get/get.dart';
import 'package:top_ai_assignment/animations/zoom_in_animation.dart';
import 'package:top_ai_assignment/services/auth_service.dart';
import 'package:top_ai_assignment/services/supabase_service.dart';
import 'package:top_ai_assignment/services/validation_service.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoomInAnimation>(() => ZoomInAnimation(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SupabaseServiceController>(() => SupabaseServiceController());
    Get.lazyPut<ValidationServiceController>(
      () => ValidationServiceController(),
    );
  }
}

ZoomInAnimation zoomInAnimationController = Get.find<ZoomInAnimation>();
AuthController authController = Get.find<AuthController>();
ValidationServiceController validationServiceController =
    Get.find<ValidationServiceController>();
SupabaseServiceController supabaseServiceController =
    Get.find<SupabaseServiceController>();
