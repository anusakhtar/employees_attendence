import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/ApplyForLeaveController/apply_for_leave_Controller.dart';





class LecApplyLeaveWidget extends StatefulWidget {
  const LecApplyLeaveWidget({super.key});

  @override
  State<LecApplyLeaveWidget> createState() => _LecApplyLeaveWidgetState();
}

class _LecApplyLeaveWidgetState extends State<LecApplyLeaveWidget> {

  int selectedButton = 0; // Index of the selected button, 0 for none

  void _selectButton(int index) {
    setState(() {
      selectedButton = index;
    });
  }
  final ApplyForLeaveController controller =Get.put(ApplyForLeaveController());

  @override
  Widget build(BuildContext context) {
    var _focusedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: Theme.of(context).hintColor.withOpacity(0.7)));
    var _enabledBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: Theme.of(context).hintColor.withOpacity(0.5)));
    return Scaffold(
      appBar: AppBar(
        title: Text('New Leave'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Text(
                "\u2022 Please choose the day and specify the type and duration of the leave. ",
                style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                      fontSize: 15,
                    )),
              ),
              SizedBox(height: 15),
              _redStarHeading("Type"),
              SizedBox(height: 5),

            SizedBox(
              height: 60,
              child: DropdownButtonFormField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        hintText: 'Sick',
                        hintStyle: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      dropdownColor: Colors.white,

                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Sick",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedButton == 0
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).hintColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Casual",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedButton == 1
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).hintColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          _selectButton(newValue);
                        }
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.deepPurple,
                      ),
                    ),
            ),

              SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _redStarHeading("Date"),
                      Obx(() =>  Text(
                        '${controller.selectedDateRange.isNotEmpty ? _formatDateRange(controller.selectedDateRange.whereType<DateTime>().toList()) : 'No date selected'}',
                        style: TextStyle(fontSize: 12),
                      ),),

                    ],
                  ),

                  CalendarDatePicker2WithActionButtons(
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      gapBetweenCalendarAndButtons: 0,
                      calendarViewMode: DatePickerMode.day,
                      disableModePicker: true,
                      weekdayLabelTextStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      controlsTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      firstDayOfWeek: 1,
                      calendarType: CalendarDatePicker2Type.range,
                      selectedDayTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      selectedDayHighlightColor: Theme.of(context).primaryColor,
                      centerAlignModePicker: true,
                      customModePickerIcon: SizedBox(),
                    ),
                    value: controller.selectedDateRange,
                      onValueChanged: controller.setSelectedDateRange,
                  ),
                ],
              ),





              _redStarHeading("Reason"),
              TextFormField(
                // controller: _con!.descriptionController,
                style:
                    TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
                validator: (input) => input!.isEmpty ? "Enter Reason" : null,
                keyboardType: TextInputType.multiline,
                keyboardAppearance: Theme.of(context).brightness,
                maxLines: 6,
                decoration: InputDecoration(
                  // labelText: "Description",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(12),
                  hintText: "Reason",

                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).hintColor.withOpacity(0.5))),
                  focusedBorder: _focusedBorder,
                  enabledBorder: _enabledBorder,
                ),
              ),

              SizedBox(height: 15),

              BouncingWidget(
                duration: Duration(milliseconds: 80),
                scaleFactor: 0.6,
                onPressed: () {},
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 19),
                    child: Center(
                      child: Text(
                        "Submit",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.merge(
                              TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String _formatDate(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  String _formatDateRange(List<DateTime> dateRange) {
    if (dateRange.isEmpty) return '';

    // Format the start date
    String startDate = _formatDate(dateRange.first);

    // If it's a range, also include the end date
    if (dateRange.length > 1) {
      String endDate = _formatDate(dateRange.last);
      return '$startDate to $endDate';
    }

    return startDate;
  }
  _redStarHeading(String title) {
    return Row(
      children: [
        Text(
          title,
          style:TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5),
          child: Text(
            "*",
            style: TextStyle(
                color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
