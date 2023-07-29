import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  Future scanDevices() async {
    flutterBlue.startScan(timeout: const Duration(seconds: 15));
    flutterBlue.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
