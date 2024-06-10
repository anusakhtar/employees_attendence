import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:employees_attendence/widgets/apptext.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../Controller/AttendenceController/attendenceController.dart';
import '../../Controller/AttendenceDetailController/attendence_detail_controller.dart';
import 'Widgets/monthlyreport.dart';
import 'Widgets/weeklyreport.dart';

class AttendencedetailScreen extends StatelessWidget {
  AttendencedetailScreen({super.key});
  final AttendanceDetailController controller =
      Get.put(AttendanceDetailController());
  final AttendanceController attendanceController =
      Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 88,
                  stepSize: 10,
                  selectedColor: Colors.deepPurple,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 130,
                  height: 130,
                  selectedStepSize: 10,
                  roundedCap: (_, __) => true,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '26',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Days',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          'of 31 Days',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Text(
                    ' ${DateFormat('MMMM').format(controller.startDate.value)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Today History',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined),
                            const AppText(
                              text: 'Started',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            Obx(
                              () => AppText(
                                text: attendanceController
                                        .checkOutHistory.isNotEmpty
                                    ? attendanceController.checkOutHistory.last
                                    : 'Start your shift',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                textColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined),
                            const AppText(
                              text: 'Ended',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            Obx(() => AppText(
                                  text: attendanceController
                                          .checkInHistory.isNotEmpty
                                      ? attendanceController.checkInHistory.last
                                      : 'End your shift',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  textColor: Colors.red,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined),
                            const AppText(
                              text: 'Shift Hrs',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            AppText(
                              text: '--/--',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              textColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .44,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Week Time",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "16 h 08 m",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 150,
                                  height: 10,
                                  child: LinearProgressIndicator(
                                    value: 0.35, // percent filled
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "29 May - 14 Jun",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .44,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Month Time",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "48 h 50 m",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 150,
                                  height: 10,
                                  child: LinearProgressIndicator(
                                    value: 0.35, // percent filled
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "01 May - 31 May",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ToggleSwitch(
                  minWidth: 155.0,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [Colors.deepPurple],
                    [Colors.deepPurple]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade200,
                  inactiveFgColor: Colors.grey,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: const ['Weekly', 'Monthly'],
                  radiusStyle: true,
                  onToggle: (index) {
                    controller.updateSelectedTimeFrame(index!);
                  },
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(
                         vertical: 5),
                    width: 315,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.updateDate(-1);
                          },
                          child: const SizedBox(
                            height: 35,
                            width: 40,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 13,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await controller.selectDate(
                                controller.selectedDate.value, context);
                          },
                          child: const Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                            ' ${controller.formatDate(controller.startDate.value)}'),
                        const Text(
                          '-',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          controller.formatDate(controller.endDate.value),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.updateDate(1);
                          },
                          child: SizedBox(
                            height: 35,
                            width: 40,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 13,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => controller.selectedTimeFrame.value == 1
                    ? WeeklyReport()
                    : MonthlyReport()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
