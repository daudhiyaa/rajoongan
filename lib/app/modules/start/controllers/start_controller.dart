import 'package:get/get.dart';

class StartController extends GetxController {
  RxInt count = 0.obs;
  void increment() => count.value++;
}
