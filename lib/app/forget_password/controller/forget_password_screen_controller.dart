import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_assets/loading_spinner.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';

class ForgetPassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final RxBool buttonAction = RxBool(true);

  void resetPassword() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);

    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction(true);
      return;
    }

    Get.dialog(const LoadingSpinner());
    String params = '?email=${emailController.text}';
    var response = await ApiFetch.forgotPassword(params);
    Get.back();
    buttonAction(true);

    if (response != null && response['success'] == true) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      final errorMessage = response != null
          ? response['message']
          : 'Please check your credentials and try again.';
      Get.defaultDialog(
        title: 'Sign Up Failed',
        middleText: errorMessage,
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.login);
        },
      );
    }
  }
}
