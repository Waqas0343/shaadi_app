import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/spacing.dart';
import 'controller/user_informaion_strapper_controller.dart';

class UserInformationThree extends StatelessWidget {
  const UserInformationThree({super.key});

  @override
  Widget build(BuildContext context) {
    final StepperController controller = Get.find<StepperController>();
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.citizenController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.myLogoAbove),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                hintText: 'Citizenship',
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: MyColors.myLogoAbove, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: MyColors.myLogoAbove, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              onTap: () async {
                CountryCode? countryCode =
                    await controller.showCountryPickerDialog(context);
                if (countryCode != null) {
                  controller.citizenController.text = countryCode.name!;
                }
              },
            ),
            widgetSpacerVertically(),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.myLogoAbove, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: LanguagePickerDropdown(
                  initialValue: controller.selectedLanguage.value,
                  onValuePicked: (Language language) {
                    controller.setSelectedLanguage(language);
                  },
                  itemBuilder: (Language language) => Row(
                    children: <Widget>[
                      Text(language.name),
                    ],
                  ),
                ),
              ),
            ),
            widgetSpacerVertically(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Education BackGround",
                style: Get.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            widgetSpacerVertically(),
            DropdownButtonFormField<String>(
                value: controller.selectedEducation.value,
                decoration: InputDecoration(
                  labelText: "Education",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: MyColors.myLogoAbove,
                      // Replace with your primary color
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: MyColors.myLogoAbove,
                      // Replace with your primary color
                      width: 2.0,
                    ),
                  ),
                ),
                items: controller.educationTypes
                    .map(
                      (area) => DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  controller.selectedEducation.value = value ?? '';
                }),

          ],
        ),
      ],
    );
  }
}
