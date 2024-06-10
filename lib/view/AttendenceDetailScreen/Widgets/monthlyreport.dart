import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../Controller/AttendenceDetailController/attendence_detail_controller.dart';

class MonthlyReport extends StatefulWidget {
  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  late List<DateTime> _dates;
  final AttendanceDetailController controller =
      Get.find<AttendanceDetailController>();

  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  void _generateDateList() {
    DateTime currentDate = controller.startDate.value;

    _dates =
        List.generate(31, (index) => currentDate.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _generateDateList();
      return SizedBox(
          height: 292,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              DateTime currentDate = _dates[index];
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                width: 315,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EE').format(currentDate),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          DateFormat('MMM d').format(currentDate),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Started',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '08:00 am',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ended',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '05:16 pm',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overtime',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '2 hrs',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );});
  }
}
