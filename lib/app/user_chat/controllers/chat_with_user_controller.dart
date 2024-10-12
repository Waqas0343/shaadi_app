import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../helpers/toaster.dart';

class ClubGroupChatController extends GetxController {
  RxBool isAttachmentUploading = RxBool(false);
  String groupName = "Kanwal";
  String groupImageUrl = "https://via.placeholder.com/150";
  final TextEditingController textController = TextEditingController();
  final user = const types.User(id: 'user-id');
  var messages = <types.Message>[].obs;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);


  String userAvatarUrl = "https://a0.anyrgb.com/pngimg/1140/162/user-profile-login-avatar-heroes-user-blue-icons-circle-symbol-logo-thumbnail.png";

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  @override
  void onClose() {
    _recorder.closeRecorder();
    super.onClose();
  }

  Future<void> initRecorder() async {
    await _recorder.openRecorder();
  }


  void handleSendPressed(types.PartialText message) {
    final newMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    messages.add(newMessage); // Add new message to the list
  }


  void pickImage() async {

  }
  void handleAttachment(PlatformFile file) {
  }

  Future<void> onImageSelection({ImageSource imageSource = ImageSource.gallery}) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 75,
      maxWidth: 1440,
      source: imageSource,
    );

    if (result == null) {
      return; // If no image was selected, exit the function
    }

    setAttachmentUploading(true); // Start the uploading process

    final file = File(result.path); // Create a file from the result
    final bytes = await result.readAsBytes(); // Read the bytes of the image
    final image = await decodeImageFromList(bytes); // Decode the image

    setAttachmentUploading(false); // End the uploading process

    // Ensure the image path is not null or empty
    if (result.path == null || result.path.isEmpty) {
      Toaster.showToast("Unable to upload image, try again");
      return;
    }

    // Create a new image message with the selected image
    final message = types.ImageMessage(
      author: user, // The user sending the message
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(), // Unique ID for the message
      uri: result.path,
      height: image.height.toDouble(),
      name: result.name,
      size: file.lengthSync(),
      width: image.width.toDouble(),
    );

    // Add the message to the messages list
    messages.add(message); // Update the message list (make sure this is the right way to update messages in your controller)
  }

  void startRecording() async {
    await _recorder.startRecorder(toFile: 'voice_message.aac');
  }
  void stopRecording() async {
    final path = await _recorder.stopRecorder();
  }

  void sendMessage() {
    if (textController.text.isNotEmpty) {
      handleSendPressed(types.PartialText(text: textController.text));
      textController.clear();
    }
  }

  void setAttachmentUploading(bool value) {
    isAttachmentUploading.value = value;
  }
  String formatTime(DateTime dateTime) {
    return DateFormat('dd MMM, yyyy hh:mm a').format(dateTime);
  }
}
