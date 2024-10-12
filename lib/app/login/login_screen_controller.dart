import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/crypto_helper.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../helpers/connectivity.dart';
import '../../app_assets/loading_spinner.dart';
import '../../helpers/app_perferences.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController(text: 'Pakistan');

  final RxBool buttonAction = RxBool(true);
  var selectedCountryCode = "+92".obs;
  var selectedCountryFlag = ''.obs;
  final formKey = GlobalKey<FormState>();
  var isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  String? emailID;
  String? password;


  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);

    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }

    Get.dialog(const LoadingSpinner());

    final data = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = await ApiFetch.login(data);
    Get.back();
    buttonAction(true);

    if (response != null && response['success']) {
      final data = response['data'];

      // Save relevant information in preferences
      Get.find<Preferences>().setString(Keys.isToken, data['jwtToken']);
      Get.find<Preferences>().setInt(Keys.userId, data['id']);
      Get.find<Preferences>().setString(Keys.email, data['email']);
      Get.find<Preferences>().setString(Keys.isPhoneNumber, data['phoneNumber']);
      Get.find<Preferences>().setString(Keys.countryCode, data['countryCode']);
      Get.find<Preferences>().setBool(Keys.status, data['enabled']);
      Get.find<Preferences>().setString(Keys.isToken, data['refreshToken']);

      // Save basic information
      Get.find<Preferences>().setString(Keys.profileType, data['basicInformation']['profileType']);
      Get.find<Preferences>().setString(Keys.firstName, data['basicInformation']['firstName']);
      Get.find<Preferences>().setString(Keys.lastName, data['basicInformation']['lastName']);
      Get.find<Preferences>().setString(Keys.location, data['basicInformation']['location']);
      Get.find<Preferences>().setString(Keys.dob, data['basicInformation']['dateOfBirth']);
      Get.find<Preferences>().setString(Keys.gender, data['basicInformation']['gender']);
      Get.find<Preferences>().setInt(Keys.height, data['basicInformation']['height']);
      Get.find<Preferences>().setString(Keys.releationShipType, data['basicInformation']['relationshipStatus']);
      Get.find<Preferences>().setString(Keys.isChild, data['basicInformation']['anyChildren']);
      Get.find<Preferences>().setString(Keys.religion, data['basicInformation']['religion']);
      Get.find<Preferences>().setString(Keys.citizen, data['basicInformation']['nationality']);
      Get.find<Preferences>().setString(Keys.familyCast, data['basicInformation']['familyCast']);
      Get.find<Preferences>().setString(Keys.country, data['basicInformation']['country']);
      Get.find<Preferences>().setString(Keys.languages, data['basicInformation']['language']);
      Get.find<Preferences>().setString(Keys.education, data['basicInformation']['educationBackground']);
      Get.find<Preferences>().setString(Keys.work, data['basicInformation']['workBackground']);
      Get.find<Preferences>().setString(Keys.salary, data['basicInformation']['salaryRange']);

      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.defaultDialog(
        title: 'Login Failed',
        middleText: 'User does not exist. Please Check Your Credential',
        textCancel: 'No',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.login);
        },
      );
    }
  }


  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
      Get.find<Preferences>().setBool(Keys.rememberMe, rememberMe.value);
    }
  }

  void saveLoginCredentials(String value) {
    if (rememberMe.value) {
      String? encyPassword =
          password != null ? CryptoHelper.encryption(password!) : null;
      Get.find<Preferences>().setString(Keys.password, encyPassword);
      Get.find<Preferences>().setString(Keys.userId, emailID);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
