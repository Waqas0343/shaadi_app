import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:shaadi_app/helpers/server/server_config.dart';
import '../../app/payment/models/payment_model.dart';
import '../../app_assets/app_styles/strings/app_constants.dart';
import '../../app_assets/debug/debug_pointer.dart';
import '../app_perferences.dart';
import '../toaster.dart';

class ApiFetch extends getx.GetxService {
  static Dio dio = Dio();

  static Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.login + data.toString());
      response = await dio.post(
        ServerConfig.login,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }

    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast('Login successful');
          return loginResponse;
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Please Check Your Login Credentials.");
          }
        }
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Toaster.showToast("Server Error: ${response.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> signUp(Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.signUp + data.toString());
      response = await dio.post(
        ServerConfig.signUp,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }

    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Toaster.showToast(signUpResponse['message'] ?? 'Operation successful');
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Toaster.showToast("Server Error: ${response.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> forgotPassword(value) async {
    Response response;
    try {
      Debug.log(ServerConfig.forgetPassword + value);
      response = await dio.post(
        ServerConfig.forgetPassword+value,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }

    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Toaster.showToast(signUpResponse['message'] ?? 'Operation successful');
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Toaster.showToast("Server Error: ${response.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> userBasicInformation(Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.basicInformation + data.toString());
      response = await dio.post(
        ServerConfig.basicInformation,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }

    if (response.statusCode == 201) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Toaster.showToast(signUpResponse['message']);
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Toaster.showToast("Server Error: ${response.statusCode}");
      return null;
    }
  }

  static Future<List<PaymentListModel>?> getAllPackagesList() async {
    Response response;
    List<PaymentListModel>? shopList;
    try {
      Debug.log(ServerConfig.subscriptionsPackages);
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        ServerConfig.subscriptionsPackages,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log(e);
      Debug.log(s);
      return shopList;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());

      try {
        final rollsResponse = PaymentModel.fromJson(response.data);
        Toaster.showToast(rollsResponse.message);
        shopList = rollsResponse.data;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
      }
    }
    return shopList;
  }

  static Future<Map<String, dynamic>?> subScribePackageByBank(Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.subscriptionsSubscribe + data.toString());
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.subscriptionsSubscribe,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }

    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final packagesResponse = response.data;
        Toaster.showToast(packagesResponse['message']);
        return packagesResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Toaster.showToast("Server Error: ${response.statusCode}");
      return null;
    }
  }
}
