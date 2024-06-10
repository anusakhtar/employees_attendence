import 'dart:async';
import 'package:employees_attendence/widgets/apptext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../Controller/AttendenceController/attendenceController.dart';
import '../AttendenceDetailScreen/attendence_detail_screen.dart';
import 'package:slide_action/slide_action.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Employee Attendance',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Today's Status",
                      alignment: Alignment.centerLeft,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>AttendencedetailScreen());
                      },
                      child: AppText(
                        text: "Details",
                        alignment: Alignment.centerLeft,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 140,
                  width: 340,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularStepProgressIndicator(
                            totalSteps: 100,
                            currentStep: 88,
                            stepSize: 10,
                            selectedColor: Colors.deepPurple,
                            unselectedColor: Colors.grey[200],
                            padding: 0,
                            width: 110,
                            height: 110,
                            selectedStepSize: 10,
                            roundedCap: (_, __) => true,
                            child: Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('97%',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                Text('Attendence',style: TextStyle(fontSize: 11),),
                              ],
                            )),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 50,
                                width: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: AppText(
                                        text: 'Started',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Obx(() {
                                      final checkInText =
                                      controller.checkOutHistory.isNotEmpty
                                          ? '${controller.checkOutHistory.last}'
                                          : 'Start your shift';
                                      return Align(
                                        alignment:Alignment.centerLeft,
                                        child: AppText(
                                          text: checkInText,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          textColor: Colors.green, // Change the color as needed
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: AppText(
                                        text: 'Ended',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,

                                      ),
                                    ),
                                    Obx(() {
                                      final checkOutText =
                                      controller.checkInHistory.isNotEmpty
                                          ? '${controller.checkInHistory.last}'
                                          : 'End your shift';
                                      return Align(
                                        alignment:Alignment.centerLeft,
                                        child: AppText(
                                          text: checkOutText,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          textColor: Colors.red, // Change the color as needed
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                SlideAction(
                  trackBuilder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          // Show loading if async operation is being performed
                          state.isPerformingAction
                              ? "Loading..."
                              : controller.attendanceStatus == 'CheckIn'
                                  ? "Slide to CheckOut"
                                  : "Slide to CheckIn",
                        ),
                      ),
                    );
                  },
                  thumbBuilder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        // Show loading indicator if async operation is being performed
                        child: state.isPerformingAction
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
                  action: () async {
                    // Async operation
                    await Future.delayed(
                      const Duration(seconds: 2),
                      () => controller.toggleAttendance(),
                    );
                  },
                ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}
