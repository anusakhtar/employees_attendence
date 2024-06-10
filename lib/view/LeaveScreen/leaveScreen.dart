// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';



import '../../Controller/TabController/tabController.dart';
import '../ApplyForLeave/apply_for_leave.dart';
import 'TabContent/tab_Content1.dart';
import 'TabContent/tab_Content3.dart';
import 'TabContent/tab_content2.dart';


class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  String _reason = '';
  String _selectedToDateTime = '';
  DateTime _submittedDate = DateTime.now();
  String _selectedFromDateTime = '';

  Future _selectToDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        _selectedToDateTime = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future _selectFromDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        _selectedFromDateTime = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Variables to store leave data
  final int _totalLeaves = 50;
  int _pendingLeaves = 0;
  int _leaves = 0;

  // Function to calculate remaining leaves
  void _calculateLeaves() {
    setState(() {
      _pendingLeaves = _totalLeaves - _leaves;
    });
  }

  void _applyLeaves() {
    if (_pendingLeaves >= 0) {
      setState(() {
        _leaves++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Leaves not allowed"),
            content: const Text("You have no pending leaves to apply"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  List<String> reasons = ["All", "Sick", "Casual"];
  final MyTabController tabController = Get.put(MyTabController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Apply For Leave'),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          _applyLeaves();
          _calculateLeaves();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return LecApplyLeaveWidget();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 22,
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Reamaining Leaves",
                style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .45,
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
                              "Total Leaves",
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
                              "$_leaves Days",
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
                              "Your Balance: $_totalLeaves Days",
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
                    width: MediaQuery.sizeOf(context).width * .45,
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
                              "Remaining Leaves",
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
                              "$_leaves Days",
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
                              "Your Balance: $_totalLeaves Days",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2.0,
                    unselectedLabelColor:
                    Theme.of(context).unselectedWidgetColor,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    labelColor: Theme.of(context).primaryColor,
                    // isScrollable: true,
                    onTap: (index) {
                      tabController.changeTabIndex(index);
                    },
                    tabs: reasons.map<Widget>((reasons) {
                      return Tab(
                        child: Container(
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${reasons}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .merge(TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              )),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                ),
              ),
              Expanded(
                child: Obx(() {
                  switch (
                  tabController.selectedTabIndex.value) {
                    case 0:
                      return TabContent1();
                    case 1:
                      return TabContent2();
                    case 2:
                      return TabContent3();
                    default:
                      return SizedBox.shrink();
                  }
                }),
              ),

              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12),
              //     side: BorderSide(
              //         color: Theme.of(context).primaryColor, width: 1),
              //   ),
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           // ignore: prefer_const_literals_to_create_immutables
              //           children: [
              //             Text(
              //               "Total Leaves",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .headline6!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               "30",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyText1!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //           ],
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           // ignore: prefer_const_literals_to_create_immutables
              //           children: [
              //             Text(
              //               "Availed Leaves",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .headline6!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               "30",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyText1!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //           ],
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           // ignore: prefer_const_literals_to_create_immutables
              //           children: [
              //             Text(
              //               "Pending Leaves",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .headline6!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               "30",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyText1!
              //                   .merge(TextStyle(fontSize: 13)),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Leaves",
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline2!
              //       .merge(TextStyle(fontSize: 18)),
              // ),
              // _submittedDate == null
              //     ? const Center(
              //         child: Text('No Form Submitted Yet'),
              //       )
              //     : ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: 1,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Card(
              //             elevation: 3,
              //             clipBehavior: Clip.antiAliasWithSaveLayer,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                 Container(
              //                   height: 25,
              //                   width: kWidth(context),
              //                   decoration: BoxDecoration(color: Colors.green),
              //                   child: Center(
              //                       child: Text(
              //                     "Allowed",
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .headline6!
              //                         .merge(TextStyle(
              //                             letterSpacing: 1.0,
              //                             fontSize: 13,
              //                             color: Colors.white)),
              //                   )),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(12),
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           leaveDetailRow(
              //                               "Reason:", "Urgent piece of work"),
              //                           InkWell(
              //                             onTap: () {},
              //                             child: Center(
              //                               child:
              //                                   Icon(Icons.more_vert_rounded),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       leaveDetailRow("From:", "2023-02-12"),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       leaveDetailRow("To:", "2023-12-31"),
              //                     ],
              //                   ),
              //                 ),
              //                 // Text(
              //                 //     'From: ${_selectedFromDateTime.toString()} To: ${_selectedToDateTime.toString()}'),
              //                 // Text(
              //                 //     'Submitted On: ${_submittedDate.toString()}'),
              //               ],
              //             ),
              //           );
              //         },
              //       ),
            ],
          ),
        ),
      ),
    );
  }

  leaveDetailRow(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .merge(TextStyle(fontSize: 15)),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .merge(TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class LecApplyLeaveDialogWidget extends StatefulWidget {
  const LecApplyLeaveDialogWidget({super.key});

  @override
  State<LecApplyLeaveDialogWidget> createState() =>
      _LecApplyLeaveDialogWidgetState();
}

class _LecApplyLeaveDialogWidgetState extends State<LecApplyLeaveDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Stack(
          children: [
            Form(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Apply Leave",
                          style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                      ),
                      child: TextFormField(
                        // keyboardType: TextInputType.number,

                        keyboardAppearance: Theme.of(context).brightness,
                        // initialValue: (widget.program == null)
                        //     ? ""
                        //     : "${widget.program}",
                        maxLines: null,
                        cursorColor: Theme.of(context).focusColor,
                        // onSaved: (input) => _con!.detail = input!,
                        validator: (input) =>
                        (input!.isEmpty) ? 'Please enter title' : null,
                        style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          labelText: "Reason",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   onChanged: (value) {
                    //     // _reason = value;
                    //   },
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please enter reason';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: const InputDecoration(labelText: 'Reason'),
                    // ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: TextFormField(
                              // controller: _con!.textEditingControllerStart,
                              // focusNode: NoKeyboardEditableTextFocusNode(),
                              maxLines: null,
                              cursorColor: Theme.of(context).focusColor,
                              // onSaved: (input) => _con!.startDate = input,
                              validator: (input) =>
                              (input!.isEmpty) ? 'Enter From date' : null,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).focusColor),
                              onTap: () {
                                // _con!.pickDateStartFun();
                              },
                              decoration: InputDecoration(
                                labelText: 'From',
                                hintText: 'From',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor),
                                contentPadding:
                                EdgeInsets.fromLTRB(5, 10, 5, 5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: TextFormField(
                              // controller: _con!.textEditingControllerEnd,
                              // focusNode: NoKeyboardEditableTextFocusNode(),
                              maxLines: null,
                              cursorColor: Theme.of(context).focusColor,
                              // onSaved: (input) => _con!.endDate = input,
                              validator: (input) =>
                              (input!.isEmpty) ? 'Enter To date' : null,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              onTap: () {
                                // _con!.pickDateEndFun();
                              },
                              decoration: InputDecoration(
                                labelText: 'To',
                                hintText: 'To',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor),
                                contentPadding:
                                EdgeInsets.fromLTRB(5, 10, 5, 5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                // checkStoragePermission().then(
                                //   (value) => {
                                // (value)
                                //     ? {_con!.getFile()}
                                //     : {
                                //         Flushbar(
                                //           flushbarPosition:
                                //               FlushbarPosition.TOP,
                                //           message:
                                //               "Permission Not Granted",
                                //           duration:
                                //               Duration(seconds: 3),
                                //         )..show(context)
                                //       },
                                //   },
                                // );
                              },
                              child: Container(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(
                                      TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // if (!_con!.isLoading) _con!.sendData();
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                decoration: BoxDecoration(
                                    color:
                                    // (_con!.isLoading)
                                    //     ? Theme.of(context)
                                    //         .primaryColor
                                    //         .withOpacity(0.8)
                                    //     :
                                    Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // "${widget.title}",
                                        "Apply",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .merge(
                                          TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // if (_con!.isLoading) SizedBox(width: 8),
                                      // if (_con!.isLoading)
                                      //   SizedBox(
                                      //     height: 15,
                                      //     width: 15,
                                      //     child: CircularProgressIndicator(
                                      //       strokeWidth: 2.0,
                                      //       valueColor:
                                      //           AlwaysStoppedAnimation<Color>(
                                      //               Colors.white),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // InkWell(
                    //   // onTap: () => _selectFromDateTime(context),
                    //   child: IgnorePointer(
                    //     child: TextField(
                    //       decoration: const InputDecoration(
                    //         labelText: 'Select From Date',
                    //         suffixIcon: Icon(Icons.calendar_today),
                    //       ),
                    //       enabled: false,
                    //       // controller: TextEditingController(text: _selectedFromDateTime),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   // onTap: () => _selectToDateTime(context),
                    //   onTap: () {},
                    //   child: IgnorePointer(
                    //     child: TextField(
                    //       decoration: const InputDecoration(
                    //         labelText: 'Select From Date',
                    //         suffixIcon: Icon(Icons.calendar_today),
                    //       ),
                    //       enabled: false,
                    //       // controller: TextEditingController(text: _selectedToDateTime),
                    //     ),
                    //   ),
                    // ),
                    // TextButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       // _submittedDate = DateTime.now();
                    //     });
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: const Text('Submit'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
