import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final RxList<String> checkInHistory = <String>[].obs;
  final RxList<String> checkOutHistory = <String>[].obs;

  String get attendanceStatus {
    return checkInHistory.length < checkOutHistory.length ? 'CheckIn' : 'CheckOut';
  }


  String get remainingWorkingHours {
    if (checkInHistory.isEmpty || checkOutHistory.isEmpty) {
      return ''; // or '--' or any default value based on your requirements
    }

    final dateFormat = DateFormat("hh:mm:ss a");

    final checkInTime = dateFormat.parse(checkInHistory.last);
    final checkOutTime = dateFormat.parse(checkOutHistory.last);

    final difference = checkOutTime.difference(checkInTime);

    return difference.toString();
  }


  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    return '$hours hours $minutes minutes';
  }
  void toggleAttendance() {
    String currentTime = getCurrentTime();

    if (attendanceStatus == 'CheckIn') {
      checkInHistory.add('$currentTime');
    } else {
      checkOutHistory.add('$currentTime');
    }

    update(); // Trigger UI update
  }



  String getCurrentTime() {
    DateFormat dateFormat = DateFormat("hh:mm:ss a");
    DateTime now = DateTime.now();
    return dateFormat.format(now);
  }
  String getCurrentDate() {
    DateFormat dateFormat = DateFormat("dd MMM yyyy");
    DateTime now = DateTime.now();
    return dateFormat.format(now);
  }
  String getJustDate() {
    DateFormat dateFormat = DateFormat("dd");
    DateTime now = DateTime.now();
    return dateFormat.format(now);
  }

  String getCurrentDay() {
    DateFormat dayFormat = DateFormat("EEE");
    DateTime now = DateTime.now();
    return dayFormat.format(now);
  }
  var currentTime = ''.obs;
  var currentDate = ''.obs;
  var currentDay = ''.obs;
  var justDate = ''.obs;

  void updateTime() {
    currentTime.value = getCurrentTime();
  }
  void updateDate() {
    currentDate.value = getCurrentDate();
  }
  void updateDay() {
    currentDay.value = getCurrentDay();
  }
  void updatejustDate() {
    justDate.value = getJustDate();
  }
}
