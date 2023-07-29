import 'package:get/get.dart';

class MapController extends GetxController {
  RxInt counter = 0.obs;

  void increment() {
    counter.value++;
  }
}
