import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/my_button.dart';
import '../../app_assets/spacing.dart';
import '../routes/app_routes.dart';
import 'controller/easy_paisa_payment_controller.dart';

class EasyPaisaPayment extends StatelessWidget {
  const EasyPaisaPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final EasyPaisaPaymentController controller = Get.put(EasyPaisaPaymentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Easy Paisa Payment"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bank logo
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwqruf1UvmRQzQT9ZHzt8juyl_9QQcbzjicA&s', // Replace with the actual logo URL
              height: 100,
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                // Bank details box
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.myLogoAbove, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(controller.bankDetails.toString()),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 30,
                  child: Row(
                    children: [
                      Text('Copy', style: Get.textTheme.titleSmall,),
                      IconButton(
                        icon: const Icon(Icons.copy, color: MyColors.myLogoAbove),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: controller.bankDetails));
                          Get.snackbar(
                            'Copied',
                            'Details copied to clipboard!',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
                  () => Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColors.primaryColor, width: 2),
                ),
                child: controller.profilePhotoBase64.value.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(
                        Icons.cloud_upload,
                        color: MyColors.myLogoAbove,
                        size: 60,
                      ),
                    ),
                    widgetSpacerVertically(),
                    Text(
                      "Upload Your Payment Screenshot",
                      style: Get.textTheme.titleSmall?.copyWith(),
                    )
                  ],
                )
                    : Image.memory(
                  base64Decode(controller.profilePhotoBase64.value),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),

            const SizedBox(height: 20),
            MyButton(
              text: 'Submit',
              color: MyColors.myLogoAbove,
              onTap: () async {
                controller.packagesSubscribes();
              },
            ),
          ],
        ),
      ),
    );
  }
}
