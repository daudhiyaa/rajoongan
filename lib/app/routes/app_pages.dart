import 'package:get/get.dart';
import 'package:rajoongan/app/modules/ble/bindings/ble_binding.dart';
import 'package:rajoongan/app/modules/ble/views/ble_view.dart';

import 'package:rajoongan/app/modules/hasil_tangkap/bindings/hasil_tangkap_binding.dart';
import 'package:rajoongan/app/modules/hasil_tangkap/views/hasil_tangkap_view.dart';
import 'package:rajoongan/app/modules/home/bindings/home_binding.dart';
import 'package:rajoongan/app/modules/home/views/home_view.dart';
import 'package:rajoongan/app/modules/login/bindings/login_binding.dart';
import 'package:rajoongan/app/modules/login/views/login_view.dart';
import 'package:rajoongan/app/modules/map/bindings/map_binding.dart';
import 'package:rajoongan/app/modules/map/views/map_view.dart';
import 'package:rajoongan/app/modules/signup/bindings/signup_binding.dart';
import 'package:rajoongan/app/modules/signup/views/signup_view.dart';
import 'package:rajoongan/app/modules/start/bindings/start_binding.dart';
import 'package:rajoongan/app/modules/start/views/start_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () => const StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.BLE,
      page: () => BLEView(),
      binding: BLEBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PAGE,
      page: () => const MapPage(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.HASIL_TANGKAP,
      page: () => HasilTangkapPage(),
      binding: HasilTangkapBinding(),
    ),
  ];
}
