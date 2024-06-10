import 'package:get/get.dart';



class ApplyForLeaveController extends GetxController {
  var selectedDateRange = <DateTime?>[].obs;

  void setSelectedDateRange(List<DateTime?> range) {
    selectedDateRange.value = range;
  }


}