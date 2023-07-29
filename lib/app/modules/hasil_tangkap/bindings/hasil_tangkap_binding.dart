import 'package:get/get.dart';
import 'package:rajoongan/app/modules/hasil_tangkap/controllers/hasil_tangkap_controller.dart';

class HasilTangkapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilTangkapController>(
      () => HasilTangkapController(),
    );
  }
}
