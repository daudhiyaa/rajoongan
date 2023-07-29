import 'package:get/get.dart';
import 'package:rajoongan/app/modules/start/controllers/start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(
      () => StartController(),
    );
  }
}
