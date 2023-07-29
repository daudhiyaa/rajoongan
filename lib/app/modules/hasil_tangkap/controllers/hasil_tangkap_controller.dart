import 'package:get/get.dart';

class HasilTangkapController extends GetxController {
  RxInt counter = 0.obs;

  void increment() {
    counter.value++;
  }
}
