import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app/payment/widget/payment_shimmer.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/my_button.dart';
import '../routes/app_routes.dart';
import 'controller/payment_package_controller.dart';

class PaymentPackages extends StatelessWidget {
  const PaymentPackages({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentPackageController controller = Get.put(PaymentPackageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Packages"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.myLogoAbove,
            ),
            child: Column(
              children: [
                const Text(
                  'Our Packages',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: PaymentShimmer());
                  } else if (controller.packagesList.isEmpty) {
                    return const Center(child: Text('No shops found.'));
                  } else {
                    return  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: controller.packagesList.length,
                      itemBuilder: (context, index) {
                        final package = controller.packagesList[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectPackage(index);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Payment Method'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MyButton(
                                        text: 'Pay By Bank',
                                        color: MyColors.myLogoAbove,
                                        onTap: () async {
                                          Get.toNamed(AppRoutes.bankpayment, arguments: package.id);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      MyButton(
                                        text: 'Jazz Cash',
                                        color: MyColors.myLogoAbove,
                                        onTap: () async {
                                          Get.toNamed(AppRoutes.jazzCashPayment, arguments: package.id);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      MyButton(
                                        text: 'Easy Paisa',
                                        color: MyColors.myLogoAbove,
                                        onTap: () async {
                                          Get.toNamed(AppRoutes.easyPaisaPayment, arguments: package.id);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Obx(
                                () => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                controller.selectedPackageIndex.value == index
                                    ? Colors.white
                                    : Colors.white70,
                                border:
                                controller.selectedPackageIndex.value == index
                                    ? Border.all(
                                    color: MyColors.myLogoBelow, width: 2)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rs ${package.price.toStringAsFixed(0)} ',
                                    style: TextStyle(
                                      color:
                                      controller.selectedPackageIndex.value ==
                                          index
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('${package.durationValue} ${package.durationUnit}'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                  }
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
          sectionSmallSpacerVertically(),
          MyButton(
            text: 'SUBSCRIBE',
            color: MyColors.myLogoAbove,
            onTap: () async {
              Get.offAllNamed(AppRoutes.home);
            },
          ),
          widgetSpacerVertically(),
          SizedBox(
            height: 45,
            width: Get.width,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.paymentVideo);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: MyColors.myLogoAbove, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
              child: Text(
                "Watch Payment Video",
                style: Get.textTheme.titleSmall
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
