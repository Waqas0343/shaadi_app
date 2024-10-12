import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadi_app/app_assets/spacing.dart';

import 'app_styles/my_images.dart';


class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Image.asset(MyImages.loadingGif, height: 40,),
          widgetSpacerHorizontally(),
          Text("Please Wait...",
            style: Get.theme.textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}