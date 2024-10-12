import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/debug/debug_pointer.dart';

class UserInformationController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var selectedProfileArea = 'Myself'.obs;
  DateTime dateTime = DateTime.now();
  List<String> serviceAreas = [
    'Myself',
    'Sister',
    'Brother',
    'Son',
    'Daughter'
  ];
  List<String> heightList = List.generate(101, (index) => '${150 + index} cm');
  var selectedGender = 'Male'.obs;
  var selectedRelation = 'Single'.obs;
  var selectedHeight = '170 cm'.obs;

  RxString profilePhotoBase64 = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      profilePhotoBase64.value = base64Encode(await pickedFile.readAsBytes());
      final bytes = await File(pickedFile.path).readAsBytes();
      profilePhotoBase64.value = base64Encode(bytes);
      Debug.log(
          '......................................${profilePhotoBase64.value}');
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

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void selectedRelationShip(String gender) {
    selectedRelation.value = gender;
  }
  void updateHeight(String height) {
    selectedHeight.value = height;
  }
}
