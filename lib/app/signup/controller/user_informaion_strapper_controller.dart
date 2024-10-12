import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:language_picker/languages.dart';
import 'package:shaadi_app/app/routes/app_routes.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../app_assets/loading_spinner.dart';
import '../../../helpers/app_perferences.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../stepper/custom_stepper_widget.dart';
import '../user_information_four.dart';
import '../user_information_one.dart';
import '../user_information_three.dart';
import '../user_information_two.dart';

class StepperController extends GetxController {
  final TextEditingController countryController = TextEditingController(text: 'Pakistan');
  final TextEditingController citizenController = TextEditingController(text: 'Pakistan');
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController familyCastController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var selectedProfileArea = 'Myself'.obs;
  var selectedRelationshipType = 'Single'.obs;
  var selectedReligionType = 'Muslim-Sunni'.obs;
  var selectedLanguage = Languages.english.obs;
  var selectedGender = 'Male'.obs;
  var selectedChild = 'No'.obs;
  var selectedHeight = '170'.obs;
  var selectedEducation = 'Matric'.obs;
  var selectedWork = 'Job'.obs;
  var selectedSalary = '20-40k PKR'.obs;
  DateTime dateTime = DateTime.now();
  List<String> serviceAreas = [
    'Myself',
    'Sister',
    'Brother',
    'Son',
    'Daughter'
  ];
  List<String> relationTypes = ['Single', 'Married', 'Divorced', 'Other'];
  List<String> religionTypes = [
    'Muslim-Sunni',
    'Muslim-Shia',
    'Christianity',
    'Hinduism',
    'Other',
  ];
  List<String> educationTypes = [
    'Matric',
    'FA',
    'BA',
    'MA',
    'Other',
  ];
  List<String> educationWorkType = [
    'Job',
    'Business',
    'Other',
  ];
  List<String> educationSalaryType = [
    '20-40k PKR',
    '40-60k PKR',
    '60-100k PKR',
    '60-100k PKR',
    '1 lakh to 2 lakh',
    '2 Lakh to 3 Lakh'
  ];

  List<String> educationChildren = [
    'No',
    'Yes',
    'Other',
  ];
  List<String> heightList = List.generate(101, (index) => '${150 + index}');

  RxString profilePhotoBase64 = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> basicInfoOneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> basicInfoThreeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> basicInfoTwoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> basicInfoFourFormKey = GlobalKey<FormState>();
  final RxBool termAndConditionCheckbox = RxBool(false);
  final RxBool buttonAction = RxBool(true);
  final RxBool _hasError = RxBool(false);
  final RxInt currentStep = RxInt(0);
  var otpCode = ''.obs;
  var countdownTime = 120.obs;
  late Timer _timer;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  String email = Get.find<Preferences>().getString(Keys.email) ?? "";

  @override
  void onInit() {
    super.onInit();
    Debug.log('......................... $email');
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownTime.value > 0) {
        countdownTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    countdownTime.value = 120;
    startTimer();
  }

  void onOTPEntered(String code) {
    otpCode.value = code;
  }

  List<CustomStep> get buildStep {
    return [
      CustomStep(
        title: currentStep.value == 0 ? const Text('Basic Info') : null,
        content: Form(
          key: basicInfoOneFormKey,
          child: const UserInformationOne(),
        ),
        isActive: currentStep.value >= 0,
        state: currentStep.value > 0
            ? CustomStepState.complete
            : CustomStepState.indexed,
      ),
      CustomStep(
        title: currentStep.value == 1 ? const Text('Personal Info') : null,
        content: Form(
          key: basicInfoTwoFormKey,
          child: const UserInformationTwo(),
        ),
        isActive: currentStep.value >= 1,
        state: currentStep.value > 1
            ? CustomStepState.complete
            : CustomStepState.indexed,
      ),
      CustomStep(
        title: currentStep.value == 2 ? const Text('Professional Info') : null,
        content: Form(
          key: basicInfoThreeFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: const UserInformationThree(),
        ),
        isActive: currentStep.value >= 2,
        state: currentStep.value > 2
            ? CustomStepState.complete
            : CustomStepState.indexed,
      ),
      CustomStep(
        title: currentStep.value == 3 ? const Text('Job Information') : null,
        content: Form(
          key: basicInfoFourFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: const UserInformationFour(),
        ),
        isActive: currentStep.value >= 3,
        state: currentStep.value > 3
            ? CustomStepState.complete
            : CustomStepState.indexed,
      ),
    ];
  }

  set hasError(bool value) {
    _hasError(value);
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

  Future<void> pickDate(TextEditingController dateController) async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      dateController.text = dateFormat.format(date);
      dateTime = date;
    }
  }

  void showIdentityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Choose Profile Photo",
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(
                      Icons.camera,
                      color: MyColors.myLogoAbove,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                    label: Text(
                      "Camera",
                      style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyColors.myLogoAbove),
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.image,
                      color: MyColors.myLogoAbove,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                    label: Text(
                      "Gallery",
                      style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyColors.myLogoAbove),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
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

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void updateHeight(String height) {
    selectedHeight.value = height;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void setSelectedLanguage(Language language) {
    selectedLanguage.value = language;
  }

  Future<void> saveInformationAndNavigateHome() async {
    if (!basicInfoOneFormKey.currentState!.validate()) return;
    basicInfoOneFormKey.currentState!.save();
    buttonAction(false);

    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction(true);
      return;
    }

    Get.dialog(const LoadingSpinner());
    Debug.log(profilePhotoBase64.value);

    final data = {
      "profilePic": profilePhotoBase64.value,
      "profileType": selectedProfileArea.value,
      "email": email,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "location": locationController.text,
      "dateOfBirth": dateController.text,
      "gender": selectedGender.value,
      "height": int.parse(selectedHeight.value.replaceAll(RegExp(r'[^0-9]'), '')),
      "relationshipStatus": selectedRelationshipType.value,
      "anyChildren": selectedChild.value,
      "religion": selectedReligionType.value,
      "nationality": citizenController.text,
      "familyCast": familyCastController.text,
      "country": countryController.text,
      "language": selectedLanguage.value.name,
      "educationBackground": selectedEducation.value,
      "workBackground": selectedWork.value,
      "salaryRange": selectedSalary.value,
    };

    Debug.log("The Sending Data In Api: $data");
    var response = await ApiFetch.userBasicInformation(data);
    Get.back();
    buttonAction(true);

    if (response != null && response['success'] == true) {
      Get.find<Preferences>().setString(Keys.email, selectedProfileArea.value);
      Get.find<Preferences>().setString(Keys.gender, selectedGender.value);
      Get.find<Preferences>().setString(Keys.firstName, firstNameController.text);
      Get.find<Preferences>().setString(Keys.lastName, lastNameController.text);
      Get.find<Preferences>().setString(Keys.location, locationController.text);
      Get.find<Preferences>().setString(Keys.dob, dateController.text);
      Get.find<Preferences>().setString(Keys.height, selectedHeight.value);
      Get.find<Preferences>().setString(Keys.releationShipType, selectedRelationshipType.value);
      Get.find<Preferences>().setString(Keys.isChild, selectedChild.value);
      Get.find<Preferences>().setString(Keys.religion, selectedReligionType.value);
      Get.find<Preferences>().setString(Keys.citizen, citizenController.text);
      Get.find<Preferences>().setString(Keys.familyCast, familyCastController.text);
      Get.find<Preferences>().setString(Keys.country, countryController.text);
      Get.find<Preferences>().setString(Keys.education, selectedEducation.value);
      Get.find<Preferences>().setString(Keys.work, selectedWork.value);
      Get.find<Preferences>().setString(Keys.languages, selectedLanguage.value.name);
      Get.find<Preferences>().setString(Keys.salary, selectedSalary.value);
      Get.find<Preferences>().setBool(Keys.status, true);
      Get.offAllNamed(AppRoutes.home);
    } else {
      final errorMessage = response != null
          ? response['message']
          : 'Please check your credentials and try again.';
      Get.defaultDialog(
        title: 'Failed To Save',
        middleText: errorMessage,
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.userInformationStepper);
        },
      );
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
