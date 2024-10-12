import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_assets/images_bottomsheet/image_bottom_widget.dart';
import 'controllers/chat_with_user_controller.dart';

class ChatWithUserScreen extends StatelessWidget {
  const ChatWithUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ClubGroupChatController controller = Get.put(ClubGroupChatController());
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/femal.png'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(controller.groupName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.messages.isNotEmpty) {
                Future.microtask(() => scrollController.jumpTo(scrollController.position.maxScrollExtent));
              }

              return Chat(
                customDateHeaderText: controller.formatTime,
                messages: controller.messages,
                onSendPressed: (types.PartialText message) {
                  controller.handleSendPressed(message);
                },
                user: controller.user,
                bubbleBuilder: (widget, {required message, required bool nextMessageInGroup}) {
                  bool isSender = message.author.id == controller.user.id;
                  return Column(
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (!isSender)
                            CircleAvatar(
                              backgroundImage: NetworkImage(controller.userAvatarUrl),
                              radius: 16,
                            ),

                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSender ? Colors.indigo : Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(8),
                                  topRight: isSender ? const Radius.circular(8) : const Radius.circular(0),
                                  bottomLeft: isSender ? const Radius.circular(8) : const Radius.circular(0),
                                  bottomRight: isSender ? const Radius.circular(0) : const Radius.circular(8), // Rounded bottom-right corner
                                ),
                              ),
                              padding: const EdgeInsets.all(6),
                              constraints: const BoxConstraints(
                                maxWidth: 250, // Max width of the message bubble
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget,
                                  const SizedBox(height: 4), // Spacing between message and time
                                  Text(
                                    controller.timeFormat.format(DateTime.fromMillisecondsSinceEpoch(message.createdAt!)),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSender ? Colors.white70 : Colors.black54, // Text color based on sender
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (isSender)
                            const SizedBox(width: 8),
                          if (isSender)
                            CircleAvatar(
                              backgroundImage: NetworkImage(controller.userAvatarUrl),
                              radius: 16,
                            ),
                        ],
                      ),
                    ],
                  );
                },
                showUserAvatars: true,
                isAttachmentUploading: controller.isAttachmentUploading.value,
                onAttachmentPressed: () {
                  Get.bottomSheet(
                    ImagePickerBottomSheet(
                      onCameraTap: () async {
                        Get.back();
                        controller.onImageSelection(imageSource: ImageSource.camera);
                      },
                      onGalleryTap: () async {
                        Get.back();
                        controller.onImageSelection();
                      },
                      isShow: false,
                    ),
                  );
                },
                customStatusBuilder: (message, {required BuildContext context}) {
                  if (message.author.id == controller.user.id) {
                    if (message.status == types.Status.delivered) {
                      return const Icon(Icons.done_all, size: 16, color: Colors.blue);
                    } else {
                      return const Icon(Icons.done_all, size: 16, color: Colors.grey);
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
