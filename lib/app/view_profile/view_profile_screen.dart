import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app/routes/app_routes.dart';
import 'package:shaadi_app/app_assets/app_styles/my_colors.dart';
import 'package:shaadi_app/app_assets/spacing.dart';
import '../../app_assets/my_button.dart';
import 'controller/view_profile_controller.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewProfileController controller = Get.put(ViewProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanwal'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(12),
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Banner Container
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/banners/slider1.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Profile Image Positioned on Top
              const Positioned(
                bottom: -40,
                left: 14,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/femal.png'),
                ),
              ),
            ],
          ),
          sectionSmallSpacerVertically(),
          sectionSmallSpacerVertically(),
          ListTile(
            title: Text('Kanwal',
                style: Get.textTheme.titleSmall
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: MyColors.myLogoAbove,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sindh, Pakistan',
                      style: Get.textTheme.titleSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.search,
                        size: 16, color: MyColors.myLogoAbove),
                    const SizedBox(width: 4),
                    Text('Seeking Male 18 - 60',
                        style: Get.textTheme.titleSmall),
                  ],
                ),
              ],
            ),
            trailing: const Text('60%', style: TextStyle(color: Colors.purple)),
          ),
          widgetSpacerVertically(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About',
                      style: Get.textTheme.titleSmall?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  widgetSpacerVertically(),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Gender: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Female",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Qualification: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Bachelor in Computer Science",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Status: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Single",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "City: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Karachi",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Family: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Living in Joint Family",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Siblings: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "2 Brothers (1 Married), 2 Sisters",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          widgetSpacerVertically(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Connect to Unlock',
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    )),
                widgetSpacerVertically(),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email Address',
                      style: Get.textTheme.titleSmall?.copyWith()),
                  subtitle: Text('*******************@gmail.com',
                      style: Get.textTheme.titleSmall?.copyWith()),
                  trailing: ElevatedButton(onPressed: (){
                    Get.toNamed(AppRoutes.chatWithUser );
                  }, child: Text('Chat')),
                ),
                const Divider(
                  height: 1,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number',
                      style: Get.textTheme.titleSmall?.copyWith()),
                  subtitle: Text('******3627',
                      style: Get.textTheme.titleSmall?.copyWith()),
                ),
              ],
            ),
          ),
          Obx(
            () => Column(
              children: [
                // First ExpansionTile (Basic and Contact Details)
                ExpansionTile(
                  title: const Text(
                    'Basic and Contact Details',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Control whether this tile is expanded or collapsed
                  initiallyExpanded: controller.expandedIndex.value == 0,
                  onExpansionChanged: (bool expanded) {
                    controller.toggleExpansion(0); // Set the expanded index
                  },
                  children: <Widget>[
                    ListTile(
                      title: Text('Email Address: *********@gmail.com'),
                    ),
                    ListTile(
                      title: Text('Mobile Number: *****3627'),
                    ),
                  ],
                ),

                // Second ExpansionTile (Other Details)
                ExpansionTile(
                  title: const Text(
                    'Additional Details',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: controller.expandedIndex.value == 1,
                  onExpansionChanged: (bool expanded) {
                    controller.toggleExpansion(1); // Set the expanded index
                  },
                  children: <Widget>[
                    ListTile(
                      title: Text('Siblings: 2 Brothers, 2 Sisters'),
                    ),
                    ListTile(
                      title: Text('Status: Single'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 12, right: 12),
          child: MyButton(
            text: 'Request Send',
            color: MyColors.myLogoAbove,
            onTap: () async {
              // Get.offAllNamed(AppRoutes.home);
            },
          ),
        ),
      ),
    );
  }
}
