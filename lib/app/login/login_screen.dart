import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../app_assets/my_button.dart';
import '../routes/app_routes.dart';
import 'login_screen_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 40 * h,
                  width: 450,
                  child: Image.asset(
                    'assets/images/loginlogo2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 6 * w,
                  top: 19 * h,
                  child: Image.asset(
                    MyImages.logoWhite,
                    height: 150,
                    width: 150,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onTap: () => Get.back(),
                  ),
                ),
                const Positioned(
                  top: 120,
                  left: 35,
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutofillGroup(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionSmallSpacerVertically(),
                          // Obx(() => TextFormField(
                          //   controller: controller.phoneController,
                          //   keyboardType: TextInputType.phone,
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter a phone number';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderSide: const BorderSide(color: MyColors.myLogoAbove),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide: const BorderSide(color: Colors.red),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     labelText: 'Phone',
                          //     hintStyle: const TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //     labelStyle: const TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //     hintText: '1234567890',
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: const BorderSide(color: MyColors.myLogoAbove, width: 2.0),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: const BorderSide(color: MyColors.myLogoAbove, width: 2.0),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     prefixIcon: Padding(
                          //       padding: const EdgeInsets.only(left: 0.0, right: 8.0),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           border: Border.all(color: MyColors.myLogoAbove, width: 2.0),
                          //           borderRadius: BorderRadius.circular(8.0),
                          //         ),
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             CountryCodePicker(
                          //               onChanged: (country) {
                          //                 controller.selectedCountryCode.value = country.dialCode!;
                          //                 controller.selectedCountryFlag.value = "https://flagcdn.com/48x36/${country.code!.toLowerCase()}.png"; // Update flag
                          //               },
                          //               initialSelection: controller.selectedCountryCode.value,
                          //               favorite: const ['PK', 'US', 'CA'],
                          //               showFlag: true, // Show flag in the country list
                          //               textStyle: const TextStyle(
                          //                 fontSize: 18,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //               dialogTextStyle: const TextStyle(
                          //                 fontSize: 18,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )),
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
                          widgetSpacerVertically(),
                          Obx(
                            () => TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofillHints: const [AutofillHints.password],
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              validator: (text) {
                                if (text!.isEmpty) return "Can't be empty";
                                return null;
                              },
                              onSaved: (text) => controller.password = text,
                              onChanged: controller.saveLoginCredentials,
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
                                labelText: 'Password *',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.togglePasswordVisibility();
                                  },
                                  child: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      color: MyColors.primaryColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                          widgetSpacerVertically(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            minLeadingWidth: 0,
                            horizontalTitleGap: 2,
                            leading: SizedBox(
                              width: 32,
                              child: Obx(
                                () => CheckboxListTile(
                                  value: controller.rememberMe.value,
                                  onChanged: (value) {
                                    controller.toggleRememberMe(value);
                                    TextInput.finishAutofillContext();
                                  },
                                ),
                              ),
                            ),
                            title: Text(
                              'Remember Me',
                              style: Get.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: GestureDetector(
                              child: const Text(
                                'Forgot Password',
                                style:
                                    TextStyle(color: MyColors.myLogoAbove),
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.forgetPassword);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: MyButton(
                              text: 'SIGN IN',
                              color: MyColors.myLogoAbove,
                              onTap: () async {
                               controller.login();
                              },
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.signUpScreen);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.myLogoBelow
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
