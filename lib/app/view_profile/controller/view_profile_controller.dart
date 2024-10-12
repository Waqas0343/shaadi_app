import 'package:get/get.dart';

class ViewProfileController extends GetxController {
  // Add your profile data here
  var profileName = 'Kanwal'.obs;
  var location = 'Sindh, Pakistan'.obs;
  var seeking = 'Seeking Male 18 - 60'.obs;
  var about = '''
    Gender: Female
    Qualification: 
    Status: Single
    City: Karachi
    Family: Living in Joint Family
    Siblings: 2 Brothers (1 Married), 2 Sisters (1 Married)
  '''.obs;
  var email = '*******************@gmail.com'.obs;
  var mobile = '******3627'.obs;
  var expandedIndex = (-1).obs;

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

}
