import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import 'controller/user_informaion_strapper_controller.dart';

class UserInformationTwo extends StatelessWidget {
  const UserInformationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final StepperController  controller = Get.find<StepperController>();
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
            DropdownButtonFormField<String>(
                value: controller.selectedHeight.value,
                decoration: InputDecoration(
                  labelText: "Height",
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
                items: controller.heightList
                    .map(
                      (area) => DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  controller.selectedHeight.value = value ?? '';
                }),
            widgetSpacerVertically(),
            DropdownButtonFormField<String>(
              value: controller.selectedRelationshipType.value,
              decoration: InputDecoration(
                labelText: "Relationship Status",
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
              items: controller.relationTypes
                  .map(
                    (area) => DropdownMenuItem(
                  value: area,
                  child: Text(area),
                ),
              )
                  .toList(),
              onChanged: (value) {
                controller.selectedRelationshipType.value = value ?? '';
              },
            ),
            widgetSpacerVertically(),

            DropdownButtonFormField<String>(
              value: controller.selectedChild.value,
              decoration: InputDecoration(
                labelText: "Any Children",
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
              items: controller.educationChildren
                  .map(
                    (area) => DropdownMenuItem(
                  value: area,
                  child: Text(area),
                ),
              )
                  .toList(),
              onChanged: (value) {
                controller.selectedChild.value = value ?? '';
              },
            ),

            widgetSpacerVertically(),

            DropdownButtonFormField<String>(
              value: controller.selectedReligionType.value,
              decoration: InputDecoration(
                labelText: "Religion",
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
              items: controller.religionTypes
                  .map(
                    (area) => DropdownMenuItem(
                  value: area,
                  child: Text(area),
                ),
              )
                  .toList(),
              onChanged: (value) {
                controller.selectedReligionType.value = value ?? '';
              },
            ),
            widgetSpacerVertically(),
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
                hintText: 'Select Nationality',
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
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.password],
              controller: controller.familyCastController,
              validator: (text) {
                if (text!.isEmpty) return "Can't be empty";
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: MyColors.myLogoAbove,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: MyColors.myLogoAbove,
                    width: 2.0,
                  ),
                ),
                labelText: 'Family Cast *',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
