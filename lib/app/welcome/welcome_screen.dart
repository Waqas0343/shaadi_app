import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/my_button.dart';
import '../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/welcome-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyImages.logo,
                        scale: 4.0,
                      ),
                      widgetSpacerVertically(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: MyButton(
                          text: 'SIGN IN',
                          color: MyColors.myLogoAbove,
                          onTap: () async {
                            Get.toNamed(AppRoutes.login);
                          },
                        ),
                      ),
                      MyButton(
                        text: 'SIGN UP',
                        color: MyColors.myLogoBelow,
                        onTap: () async {
                          Get.toNamed(AppRoutes.signUpScreen);
                          // Get.toNamed(AppRoutes.userInformation);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 163,
                width: 358,
                child: Image.asset(
                  'assets/images/welcome-2.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
