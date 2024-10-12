import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../app_assets/loading_spinner.dart';
import '../../../helpers/app_perferences.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';

class SignUpScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController countryController = TextEditingController(text: 'Pakistan');
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  var selectedCountryCode = "+92".obs;
  var selectedCountryFlag = ''.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final RxBool buttonAction = RxBool(true);
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);

  bool hasError = false;
  RxString profilePhotoBase64 = ''.obs;
  String errorText = '';
  DateTime dateTime = DateTime.now();
  String? selectedDate1;
  DateTime selectedDate2 = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);

    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction(true);
      return;
    }

    Get.dialog(const LoadingSpinner());

    final data = {
      "email": emailController.text,
      "password": passwordController.text,
      "phoneNumber": whatsappController.text,
      "countryCode": selectedCountryCode.value,
    };

    var response = await ApiFetch.signUp(data);
    Get.back();
    buttonAction(true);
    if (response != null && response['success'] == true) {
      Get.find<Preferences>().setString(Keys.email, emailController.text);
      Get.find<Preferences>().setString(Keys.isPhoneNumber, whatsappController.text);
      Get.offAllNamed(AppRoutes.userInformationStepper);
    } else {
      final errorMessage = response != null ? response['message'] : 'Please check your credentials and try again.';
      Get.defaultDialog(
        title: 'Sign Up Failed',
        middleText: errorMessage,
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.signUpScreen);
        },
      );
    }
  }




  Future<CountryCode?> showCountryPickerDialog(BuildContext context) async {
    CountryCode? selectedCountry;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Country'),
        content: CountryCodePicker(
          onChanged: (country) {
            selectedCountry = country;
            Navigator.of(context).pop();
          },
          initialSelection: 'PK',
          favorite: const ['PK', 'US', 'CA'],
          showFlag: true,
          showCountryOnly: true,
          showOnlyCountryWhenClosed: true,
          searchDecoration: InputDecoration(
            hintText: 'Search Country',
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF59904)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
    return selectedCountry;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
}
