import 'package:get/get.dart';

class MyTabController extends GetxController {
  var selectedTabIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
