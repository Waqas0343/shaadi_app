import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/spacing.dart';
import 'controller/user_informaion_strapper_controller.dart';

class UserInformationFour extends StatelessWidget {
  const UserInformationFour({super.key});

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Work BackGround",
                style: Get.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            widgetSpacerVertically(),
            DropdownButtonFormField<String>(
                value: controller.selectedWork.value,
                decoration: InputDecoration(
                  labelText: "Work",
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
                items: controller.educationWorkType
                    .map(
                      (area) => DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  controller.selectedWork.value = value ?? '';
                }),
            widgetSpacerVertically(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Salary BackGround",
                style: Get.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            widgetSpacerVertically(),
            DropdownButtonFormField<String>(
                value: controller.selectedSalary.value,
                decoration: InputDecoration(
                  labelText: "Salary",
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
                items: controller.educationSalaryType
                    .map(
                      (area) => DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  controller.selectedSalary.value = value ?? '';
                }),
          ],
        ),
      ],
    );
  }
}
