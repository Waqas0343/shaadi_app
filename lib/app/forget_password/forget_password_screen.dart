import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/app_styles/my_images.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/my_button.dart';
import 'controller/forget_password_screen_controller.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPassController controller = Get.put(ForgetPassController());
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    MyImages.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                widgetSpacerVertically(),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: const Icon(Icons.email, color: MyColors.myLogoAbove),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: MyButton(
                    onTap: controller.resetPassword,
                    text: 'Reset',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}