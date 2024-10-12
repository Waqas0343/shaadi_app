import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app/home/widget/app_drawer.dart';
import 'package:shaadi_app/app/home/widget/app_search.dart';
import 'package:shaadi_app/app/routes/app_routes.dart';
import 'package:shaadi_app/app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/spacing.dart';
import '../../app_assets/custom_card_widget.dart';
import 'controller/home_controller.dart';
import 'widget/home_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        key: controller.drawerKey,

        leading: SizedBox(
          height: 38,
          width: 38,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (context) {
                  return IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.menu),
                    onPressed: Scaffold.of(context).openDrawer,
                  );
                },
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        elevation: 0,
        centerTitle: false,
        title: Image.asset(
          MyImages.logoWhite,
          color: Colors.white,
          height: 50.0,
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // controller.onTapCity,
            },
            icon: const Icon(
              Icons.pin_drop,
            ),
            label: const Text('Lahore'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
              left: 14,
              right: 14,
            ),
            child: AppBarSearchWidget(
                heroId: "Doctor Search",
                hintText: " Search Your Favourite Name",
                onTap: () {}),
          ),
        ),

      ),
      drawer: const AppDrawer(),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Banners(),
          widgetSpacerVertically(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "Good Night ",
                style: Get.textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: "Muhammad Waqas",
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: Get.width / 1.62,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Opacity(
                              opacity: 0.85,
                              child: Image.asset(
                                'assets/images/femal.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '60% Match',
                              style: Get.textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                              )
                            ),
                          ),
                        ),
                        // Content of the card
                        Column(
                          children: [
                            widgetSpacerVertically(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  widgetSpacerHorizontally(),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: MyColors.myLogoAbove, width: 2),
                                        ),
                                        child: const Icon(Icons.more_vert, color: Colors.green, size: 20,),
                                      ),
                                      Icon(Icons.favorite, color: MyColors.myLogoAbove),
                                      Icon(Icons.share, color: MyColors.myLogoAbove),
                                      Icon(Icons.play_circle_outline, color: MyColors.myLogoAbove,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            widgetSpacerHorizontally(),
                            sectionSmallSpacerVertically(),
                            Stack(
                              children: [
                                ListTile(
                                  dense: true,
                                  minLeadingWidth: 0,
                                  contentPadding: const EdgeInsets.only(top: 23.0, left: 10.0, right: 0.0),
                                  minVerticalPadding: 0,
                                  horizontalTitleGap: 0,
                                  leading: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      'https://thumbs.dreamstime.com/b/female-avatar-icon-women-clipart-png-vector-girl-avatar-women-clipart-bor-bisiness-icon-png-vector-233362315.jpg',
                                    ),
                                  ),
                                  title: Text(
                                    'Kanwal Aftab',
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Lahore, Pakistan',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -6,
                                  top: 10,
                                  child: Obx(() {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor:
                                            controller.isOnline.value ? Colors.green : Colors.red,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller.isOnline.value ? 'Online' : 'Offline',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.myLogoAbove,
                                    ),
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.viewProfile);
                                    },
                                    child: Text(
                                      'View Profile',
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.paymentPackagesModel);
                                    },
                                    child: Text(
                                      'Contact Now',
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );

                },
              ),
            ),
          ),
          const Divider(
            thickness: 5,
          ),
          widgetSpacerVertically(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 34,
            ),
            child: Column(
              children: [
                Text(
                  Keys.versionNo,
                  style: Get.textTheme.bodySmall,
                ),
                Text(
                    "Copyrights Ⓒ Shaadi Kro (Private) Limited.\n"
                    "Head Office, Lahore Punjab Pakistan\n"
                    "All rights are reserved.\n",
                    style: Get.textTheme.bodySmall,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Image.asset(
              MyImages.logo,
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: MyColors.myLogoAbove,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildBottomNavigationItem(
                  icon: Icons.home,
                  label: 'Dashboard',
                  isSelected: controller.selectedIndex.value == 0,
                  onTap: () {
                    controller.changeTabIndex(0);
                  },
                ),
                _buildBottomNavigationItem(
                  icon: Icons.search_outlined,
                  label: 'Matches',
                  isSelected: controller.selectedIndex.value == 1,
                  onTap: () {
                    controller.changeTabIndex(1);
                  },
                ),
                _buildBottomNavigationItem(
                  icon: Icons.chat_outlined,
                  label: 'Chat',
                  isSelected: controller.selectedIndex.value == 2,
                  onTap: () {
                    controller.changeTabIndex(2);
                  },
                ),
                _buildBottomNavigationItem(
                  icon: Icons.payments_outlined,
                  label: 'Upgrade',
                  isSelected: controller.selectedIndex.value == 3,
                  onTap: () {
                    controller.changeTabIndex(3);
                  },
                ),
                _buildBottomNavigationItem(
                  icon: Icons.account_circle_outlined,
                  label: 'Profile',
                  isSelected: controller.selectedIndex.value == 4,
                  onTap: () {
                    controller.changeTabIndex(4);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.white : MyColors.myLogoBelow),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : MyColors.myLogoBelow,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
