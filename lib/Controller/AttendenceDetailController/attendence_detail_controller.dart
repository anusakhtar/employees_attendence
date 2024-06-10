
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceDetailController extends GetxController {

  final selectedDate = DateTime.now().obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(Duration(days: 7)).obs;
  final selectedTimeFrame = 1.obs;


  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    updateDateRange();
  }

  void updateSelectedTimeFrame(int index) {
    selectedTimeFrame.value = index + 1;
    updateSelectedDate(selectedDate.value);

  }

  void updateDateRange() {
    if (selectedTimeFrame.value == 1) {
      startDate.value = selectedDate.value;
      endDate.value = selectedDate.value.add(Duration(days: 7));
    } else {
      startDate.value = selectedDate.value;
      endDate.value = selectedDate.value.add(Duration(days: 30));
    }
  }

  Future<DateTime?> selectDate(DateTime initialDate, BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      updateSelectedDate(picked);
    }

    return picked;
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }
  
void updateDate(int increment) {
    if (selectedTimeFrame.value == 1) {
      startDate.value = startDate.value.add(Duration(days: 7 * increment));
      endDate.value = endDate.value.add(Duration(days: 7 * increment));
    } else {
      startDate.value = startDate.value.add(Duration(days: 30 * increment));
      endDate.value = endDate.value.add(Duration(days: 30 * increment));
    }
  }


}
