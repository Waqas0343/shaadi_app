import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import 'controller/user_informaion_strapper_controller.dart';

class UserInformationOne extends StatelessWidget {
  const UserInformationOne({super.key});

  @override
  Widget build(BuildContext context) {
    final StepperController  controller = Get.find<StepperController>();
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        Column(
          children: [
            Obx(() => Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: MyColors.myLogoAbove,
                  backgroundImage:
                  controller.profilePhotoBase64.value.isNotEmpty
                      ? MemoryImage(base64Decode(
                      controller.profilePhotoBase64.value))
                      : null,
                  child: controller.profilePhotoBase64.value.isEmpty
                      ? const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.showIdentityBottomSheet(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: MyColors.myLogoBelow,
                      radius: 16,
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 8),
            Text(
              'Upload Profile Photo',
              style: Get.textTheme.titleSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            widgetSpacerVertically(),
            DropdownButtonFormField<String>(
              value: controller.selectedProfileArea.value,
              decoration: InputDecoration(
                labelText: "Profile Type",
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
              items: controller.serviceAreas
                  .map(
                    (area) => DropdownMenuItem(
                  value: area,
                  child: Text(area),
                ),
              )
                  .toList(),
              onChanged: (value) {
                controller.selectedProfileArea.value = value ?? '';
              },
            ),
            widgetSpacerVertically(),
            Obx(() {
              return Row(
                children: [
                  Text(
                    'Select Gender:',
                    style: Get.textTheme.titleSmall?.copyWith(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Radio<String>(
                    value: 'Male',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      controller.updateGender(value!);
                    },
                  ),
                  Text(
                    'Male',
                    style: Get.textTheme.titleSmall?.copyWith(),
                  ),
                  Radio<String>(
                    value: 'Female',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      controller.updateGender(value!);
                    },
                  ),
                  Text(
                    'Female',
                    style: Get.textTheme.titleSmall?.copyWith(),
                  ),
                  Radio<String>(
                    value: 'Other',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      controller.updateGender(value!);
                    },
                  ),
                  Text('Other',
                      style: Get.textTheme.titleSmall?.copyWith()),
                ],
              );
            }),
            widgetSpacerVertically(),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.password],
              controller: controller.firstNameController,
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
                labelText: 'First Name *',
                suffixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: MyColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.password],
              controller: controller.lastNameController,
              validator: (text) {
                if (text!.isEmpty) return "Can't be empty";
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Last Name *',
                suffixIcon: const Icon(
                  Icons.person,
                  color: MyColors.primaryColor,
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
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.password],
              controller: controller.locationController,
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
                labelText: 'Location *',
                suffixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: MyColors.primaryColor,
                ),
              ),
            ),
            widgetSpacerVertically(),
            GestureDetector(
              onTap: () async {
                await controller.pickDate(controller.dateController);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: controller.dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("DD/MM/YYYY"),
                    hintText: "Date",
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.calendar_month, color: MyColors.myLogoAbove,),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
