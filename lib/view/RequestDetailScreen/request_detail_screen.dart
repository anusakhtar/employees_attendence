import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/apptext.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  List<String> progressList = [
    'Pending',
    'Verification',
    'InProgress',
    'Issued',
    'Delivered'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: AppText(
          text: 'Request Details',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusRow(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade50),
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white,width: 2),
                            ),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  // child: Image.asset('assets/anus1.jpeg',fit: BoxFit.cover,),
                                  child: Icon(Icons.person,color: Colors.deepPurple,),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: 'Muhammad Anus',
                                textColor: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              AppText(
                                text: 'anusakhtar@gmail.com',
                                textColor: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone,color: Colors.white,),
                          SizedBox(width: 10,),
                          AppText(
                            text: '03431451403',
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.white,),
                          SizedBox(width: 10,),
                          AppText(
                            text: 'Minhaj university Lahore,Pipe stop',
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset('assets/personal_info.png')),
                    ),
                    SizedBox(width: 10,),
                    AppText(
                      text: 'Personal Info',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('Reference #:',
                          _buildStyledContainer('239045', Colors.teal)),
                      Divider(),
                      _buildInfoRow('Student CNIC:', '35401-2334567-1'),
                      Divider(),
                      _buildInfoRow('Date of Birth:', '12-12-2024'),
                      Divider(),
                      _buildInfoRow('Timing:', 'weekend'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset('assets/challan.png')),
                    ),
                    SizedBox(width: 10,),
                    AppText(
                      text: 'Application Info',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),


                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('Document #:', '-'),
                      Divider(),
                      _buildInfoRow('Status:',
                          _buildStyledContainer('pending', Colors.orange)),
                      Divider(),
                      _buildInfoRow('Apply Date:', '12-06-23'),
                      Divider(),
                      _buildInfoRow('Due Date:', '12-07-23'),
                      Divider(),
                      _buildInfoRow('Issue Date:', '-'),
                      Divider(),
                      _buildInfoRow('Delivered Date:', '-'),
                      Divider(),
                      _buildInfoRow('Application For:',
                          _buildStyledContainer('Degree', Colors.lightGreen)),
                      Divider(),
                      _buildInfoRow('Normal/Urgent:',
                          _buildStyledContainer('Normal', Colors.blueAccent)),
                      Divider(),
                      _buildInfoRow('Original/Duplicate:',
                          _buildStyledContainer('Original', Colors.blueAccent)),
                      Divider(),
                      _buildInfoRow('Till Semesters:', '4'),
                      Divider(),
                      _buildInfoRow('Remarks:', '-'),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: value is String
                    ? Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.right,
                      )
                    : value,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyledContainer(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildStatusRow() {
    int currentStep = 2;

    return Column(
      children: [
        StepProgressIndicator(
          totalSteps: 5,
          currentStep: currentStep,
          size: 50,
          selectedColor: _getStatusColor(currentStep),
          unselectedColor: Colors.grey,
          customStep: (index, color, _) => Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getStatusIcon(index),
                    color: Colors.white,
                    size: 22,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  AppText(
                    text: progressList[index],
                    fontSize: 10,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(int index) {
    switch (index) {
      case 0:
        return Icons.hourglass_empty;
      case 1:
        return Icons.verified;
      case 2:
        return Icons.work;
      case 3:
        return Icons.check_circle;
      case 4:
        return Icons.local_shipping;
      default:
        return Icons.circle;
    }
  }

  Color _getStatusColor(int index) {
    switch (index) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.orange;

      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.teal;
      case 4:
        return Colors.deepPurple;
      case 0:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
