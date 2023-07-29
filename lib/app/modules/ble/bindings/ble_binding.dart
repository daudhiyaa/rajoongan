import 'package:get/get.dart';
import 'package:rajoongan/app/modules/ble/controllers/ble_controller.dart';

class BLEBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BLEController>(
      () => BLEController(),
    );
  }
}
