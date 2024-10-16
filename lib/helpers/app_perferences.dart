import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_assets/debug/debug_pointer.dart';

class Preferences extends GetxService {
  late SharedPreferences _preferences;

  Future<Preferences> initial() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future setString(String key, String? value) async {
    if (value == null) return;
    try {
      await _preferences.setString(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  Future setInt(String key, int? value) async {
    if (value == null) return;
    try {
      await _preferences.setInt(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  Future setBool(String key, bool? value) async {
    if (value == null) return;
    try {
      await _preferences.setBool(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  String? getString(String key) {
    try {
      return _preferences.getString(key);
    } catch (e) {
      Debug.log("$e");
    }

    return "";
  }

  int? getInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (e) {
      Debug.log("$e");
    }
    return 0;
  }

  bool? getBool(String key) {
    try {
      return _preferences.getBool(key);
    } catch (e) {
      Debug.log("$e");
    }
    return null;
  }

  Future clear() async {
    await _preferences.clear();
  }
  Future remove(String key) async {
    try {
      await _preferences.remove(key);
    } catch (e) {
      Debug.log("$e");
    }
  }


  Future<void> logout() async {
    // final service = FlutterBackgroundService();
    // service.invoke('stopService');
    //
    // String? password = Get.find<Preferences>().getString(Keys.password);
    // String? userID = Get.find<Preferences>().getString(Keys.userId);
    // bool isEnabled = Get.find<Preferences>().getBool(Keys.fingerPrint) ?? false;
    // bool rememberMe = Get.find<Preferences>().getBool(Keys.rememberMe) ?? false;

    await Get.find<Preferences>().clear();
    // Get.find<Preferences>().setBool(Keys.isFirstTime, false);
    // Get.find<Preferences>().setBool(Keys.fingerPrint, isEnabled);
    // Get.find<Preferences>().setString(Keys.password, password);
    // Get.find<Preferences>().setString(Keys.userId, userID);
    // Get.find<Preferences>().setBool(Keys.rememberMe, rememberMe);
    //
    // Get.offAllNamed(AppRoutes.login);
  }
}