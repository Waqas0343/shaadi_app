import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../app_assets/loading_spinner.dart';
import '../../../helpers/app_perferences.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';

class EasyPaisaPaymentController extends GetxController{
  int? userID = Get.find<Preferences>().getInt(Keys.userId);
  final RxBool buttonAction = RxBool(true);
  RxString profilePhotoBase64 = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final String bankDetails = """
    Account Name : EasyPaisa
    Account title : Rashid
    Account No :  03298046430
    """;
  int? id;
  @override
  void onInit() {
    id = Get.arguments;
    super.onInit();
  }

  Future<void> packagesSubscribes() async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }

    Get.dialog(const LoadingSpinner());

    final data = {
      "userId": userID,
      "packageId": id,
      "paymentMethod": "Easy Paisa",
      "paymentScreenshot":   profilePhotoBase64.value,
    };
    Debug.log("sending Data..........$data");
    Debug.log("sending Data..........$data");
    var response = await ApiFetch.subScribePackageByBank(data);
    Get.back();
    buttonAction(true);
    if (response != null && response['success']) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      final errorMessage = response != null ? response['message'] : 'Please check your credentials and try again.';

      Get.defaultDialog(
        title: 'Login Failed',
        middleText: errorMessage,
        textCancel: 'No',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.easyPaisaPayment);
        },
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      profilePhotoBase64.value = base64Encode(await pickedFile.readAsBytes());
      final bytes = await File(pickedFile.path).readAsBytes();
      profilePhotoBase64.value = base64Encode(bytes);
      Debug.log('......................................${profilePhotoBase64.value}');
    }
  }
}