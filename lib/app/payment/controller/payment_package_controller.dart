import 'package:get/get.dart';

import '../../../helpers/server/api_fetch.dart';
import '../models/payment_model.dart';

class PaymentPackageController extends GetxController {
  final RxList<PaymentListModel> packagesList = RxList<PaymentListModel>();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    getAllPackages();
    super.onInit();
  }
  var selectedPackageIndex = 0.obs;
  void getAllPackages() async {
    isLoading(true);
    List<PaymentListModel>? responseList  = await ApiFetch.getAllPackagesList();
    isLoading(false);
    if (responseList != null) {
      packagesList.assignAll(responseList);
    }
  }
  void selectPackage(int index) {
    selectedPackageIndex.value = index;
  }
}
