import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../app_assets/loading_spinner.dart';
import '../../../helpers/app_perferences.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController{
  var isOnline = true.obs;
  final RxInt selectedIndex = 0.obs;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
  String firstName = Get.find<Preferences>().getString(Keys.firstName) ?? "";
  String lastName = Get.find<Preferences>().getString(Keys.lastName) ?? "";

  @override
  void onInit() {
    Debug.log(token);
    Debug.log(firstName);
    Debug.log(lastName);
    super.onInit();
  }
  final List<String> pageRoutes = [
    AppRoutes.home,
    AppRoutes.home,
    AppRoutes.chatWithUser,
    AppRoutes.paymentPackagesModel,
  ];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    Get.toNamed(pageRoutes[index]);
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
  Future<void> logout() async {
    try {
    } catch (e) {
      Debug.log(e);
    }
    Get.dialog(const LoadingSpinner(), barrierDismissible: false);
    Get.find<Preferences>().logout();
    Get.offAllNamed(AppRoutes.login);
  }
}