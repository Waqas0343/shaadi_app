import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/app_styles/my_images.dart';
import 'controller/user_informaion_strapper_controller.dart';
import 'stepper/custom_stepper_widget.dart';

class UserInformationStepper extends StatelessWidget {
  const UserInformationStepper({super.key});
  @override
  Widget build(BuildContext context) {
    final StepperController controller = Get.put(StepperController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.myLogoAbove,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Basic Information',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: CustomStepper(
                type: CustomStepperType.horizontal,
                steps: controller.buildStep,
                margin: EdgeInsets.zero,
                currentStep: controller.currentStep.value,
                onStepContinue: () async {
                  // Validate the forms based on the current step
                  switch (controller.currentStep.value) {
                    case 0:
                      if (!controller.basicInfoOneFormKey.currentState!.validate()) return;
                      break;
                    case 1:
                      if (!controller.basicInfoTwoFormKey.currentState!.validate()) return;
                      break;
                    case 2:
                      if (!controller.basicInfoThreeFormKey.currentState!.validate()) {
                        controller.hasError = true;
                        return;
                      }
                      break;
                    case 3:
                      if (!controller.basicInfoFourFormKey.currentState!.validate()) {
                        controller.hasError = true;
                        return;
                      }
                      break;
                  }

                  bool isFinished = controller.currentStep.value == controller.buildStep.length - 1;

                  if (isFinished) {
                    await controller.saveInformationAndNavigateHome();
                  } else {
                    controller.currentStep.value++;
                  }
                },
                onStepCancel: () async {
                  if (controller.currentStep.value == 3) {}
                  controller.currentStep.value--;
                },
                controlsBuilder: (context, CustomControlsDetails details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (controller.currentStep.value != 0)
                          TextButton.icon(
                            icon: const Icon(Icons.arrow_back_ios, size: 16, color: MyColors.myLogoBelow),
                            label: Text(
                              "BACK",
                              style: Get.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: MyColors.myLogoBelow,
                              ),
                            ),
                            onPressed: details.onStepCancel,
                          ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            backgroundColor: MyColors.myLogoAbove,
                          ),
                          child: Text(
                            "CONTINUE",
                            style: Get.textTheme.titleSmall?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ),
            Image.asset(
              MyImages.logo,
              height: 60,
            ),
          ],
        );
      }),
    );
  }
}
