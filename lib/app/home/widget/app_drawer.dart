import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_icons.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/app_styles/text_styles/text_styles.dart';
import '../../../app_assets/spacing.dart';
import '../../../helpers/toaster.dart';
import '../../routes/app_routes.dart';
import '../controller/home_controller.dart';
import 'drawer_list.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Drawer(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.home),
                  child: DrawerHeader(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                      top: 12.0,
                      right: 16,
                      left: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Image.asset(
                            MyImages.logo,
                            height: 24.0,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: MyTextStyle.height50,
                                width: MyTextStyle.height50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(MyTextStyle.height50),
                                  ),
                                  child: Image.asset(MyImages.logo),
                                ),
                              ),
                              widgetSpacerHorizontally(),
                              Expanded(
                                child: SizedBox(
                                  height: MyTextStyle.height50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Muhammad Waqas',
                                        style: Get.theme.textTheme.titleSmall!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        '11-07-1198',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.titleSmall!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                DrawerList(
                  title: "My Chats",
                  icon: MyIcons.isNotification,
                  onTap: () => Get.toNamed(AppRoutes.home),
                ),
                DrawerList(
                  title: "Article",
                  icon: MyIcons.isNotification,
                  onTap: () => Get.toNamed(AppRoutes.home),
                ),
                DrawerList(
                  title: "Events",
                  icon: MyIcons.isNotification,
                  onTap: () => Get.toNamed(AppRoutes.home),
                ),
                DrawerList(
                  title: "Notifications",
                  onTap: () => Get.toNamed(AppRoutes.home),
                  icon: MyIcons.isNotification,
                ),

                DrawerList(
                  title: "Rate Us",
                  icon: MyIcons.isNotification,
                  onTap: () async {
                    launchUrlString(
                      'https://s.instacare.pk/app',
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  },
                ),
                DrawerList(
                  title: "Share App",
                  icon: MyIcons.isNotification,
                  onTap: () {
                    Share.share('https://s.instacare.pk/app');
                  },
                ),
                DrawerList(
                  title: "Support",
                  icon: MyIcons.isNotification,
                  onTap: () => launchUrlString("tel://03171777509"),
                ),
                DrawerList(
                  title: "Privacy Policy",
                  icon: MyIcons.isNotification,
                  onTap: () {
                    Get.toNamed(AppRoutes.home);
                  },
                ),
                DrawerList(
                  title: "Switch To Accounts",
                  icon: MyIcons.isNotification,
                  onTap: () => Get.toNamed(AppRoutes.home),
                ),

                DrawerList(
                  title: "Logout",
                  icon: MyIcons.isNotification,
                  onTap: () => homeController.logout(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  Keys.versionNo,
                  style: Get.theme.textTheme.bodySmall!
                      .copyWith(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () async {
                        try {
                          bool launched = await launchUrlString(
                            "fb://page/285113098863602",
                          );
                          if (!launched) {
                            await launchUrlString(
                              "https://www.facebook.com/285113098863602",
                            );
                          }
                        } catch (e) {
                          await launchUrlString(
                            "https://www.facebook.com/285113098863602",
                          );
                        }
                      },
                      constraints: const BoxConstraints(),
                      elevation: 2.0,
                      highlightElevation: 4.0,
                      padding: const EdgeInsets.all(4),
                      shape: const CircleBorder(),
                      child: const Icon(
                        FontAwesomeIcons.facebook,
                          color: MyColors.myLogoAbove
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () async {
                        try {
                          await launchUrlString(
                            "whatsapp://send?phone=+923171777509",
                          );
                        } catch (e) {
                          Toaster.showToast('whatsapp not installed');
                        }
                      },
                      constraints: const BoxConstraints(),
                      elevation: 2.0,
                      highlightElevation: 4.0,
                      padding: const EdgeInsets.all(4),
                      shape: const CircleBorder(),
                      child: const Icon(
                        FontAwesomeIcons.whatsapp,
                          color: MyColors.myLogoAbove
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () async {
                        try {
                          bool launched = await launchUrlString(
                              "https://www.instagram.com/instacare.pk/?igshid=YmMyMTA2M2Y%3D",
                              mode: LaunchMode.externalApplication);
                          if (!launched) {
                            await launchUrlString(
                                "https://www.instagram.com/instacare.pk/?igshid=YmMyMTA2M2Y%3D",
                                mode: LaunchMode.externalApplication);
                          }
                        } catch (e) {
                          await launchUrlString(
                              "https://www.instagram.com/instacare.pk/?igshid=YmMyMTA2M2Y%3D",
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      constraints: const BoxConstraints(),
                      elevation: 2.0,
                      highlightElevation: 4.0,

                      padding: const EdgeInsets.all(4),
                      shape: const CircleBorder(),
                      child:  const Icon(
                        FontAwesomeIcons.instagram,
                        color: MyColors.myLogoAbove
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
