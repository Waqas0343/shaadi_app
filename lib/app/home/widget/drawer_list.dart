import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerList extends StatelessWidget {
  final String title;
  final String icon;
  final IconData? iconData;
  final Function? onTap;
  final int unReadNotifications;
  final bool isBottomBorder;

  const DrawerList({
    required this.icon,
    required this.title,
    this.onTap,
    this.isBottomBorder = true,
    this.iconData,
    this.unReadNotifications = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
      child: InkWell(
        onTap: () => onTap!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  if (iconData == null)
                    SvgPicture.asset(
                      icon,
                      width: 20,
                      height: 20,
                    ),
                  if (iconData != null)
                    Icon(
                      iconData,
                      size: 20,
                    ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        title,
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  if (unReadNotifications > 0)
                    Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        unReadNotifications.toString(),
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}