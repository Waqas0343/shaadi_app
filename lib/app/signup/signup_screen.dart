import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app/signup/controller/signup_controller.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../app_assets/app_styles/my_images.dart';
import '../../app_assets/my_button.dart';
import '../routes/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpScreenController controller = Get.put(SignUpScreenController());
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: h / 3,
                  width: 450,
                  child: Image.asset(
                    'assets/images/loginlogo1.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 95,
                  child: Image.asset(
                    MyImages.logoSignUp,
                    height: 150,
                    width: 150,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white),
                    onTap: () => Get.back(),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 25,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sectionSmallSpacerVertically(),
                    Obx(() => TextFormField(
                          controller: controller.whatsappController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: MyColors.myLogoAbove),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Phone',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: '1234567890',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColors.myLogoAbove, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColors.myLogoAbove, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.myLogoAbove, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CountryCodePicker(
                                      onChanged: (country) {
                                        controller.selectedCountryCode.value =
                                            country.dialCode!;
                                        controller.selectedCountryFlag.value =
                                            "https://flagcdn.com/48x36/${country.code!.toLowerCase()}.png"; // Update flag
                                      },
                                      initialSelection:
                                          controller.selectedCountryCode.value,
                                      favorite: const ['PK', 'US', 'CA'],
                                      showFlag: true,
                                      // Show flag in the country list
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      dialogTextStyle: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                    widgetSpacerVertically(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: const Icon(Icons.email,
                            color: MyColors.myLogoAbove),
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
                    const SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: const [AutofillHints.password],
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
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
                          labelText: 'Password *',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.togglePasswordVisibility();
                            },
                            child: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Password must includes at least one lower case, one upper case, one special character and length should be in between 6-25.",
                      style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyColors.shimmerBaseColor),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: const [AutofillHints.password],
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Can't be empty";
                          } else if (text !=
                              controller.passwordController.text) {
                            return "Passwords do not match";
                          }
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
                          labelText: 'Confirm password *',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                            child: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    widgetSpacerVertically(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: MyButton(
                        text: 'SIGN Up',
                        color: MyColors.myLogoAbove,
                        onTap: () async {
                          controller.signUp();
                          // Get.toNamed(AppRoutes.userInformationStepper);
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account "),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.login);
                            },
                            child: Text(
                              'Sign In',
                              style: Get.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.blueColor),
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
      ),
    );
  }
}
