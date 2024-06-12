import 'package:employees_attendence/view/ApplyForTranscript/apply_for_transcript.dart';
import 'package:employees_attendence/view/RequestDetailScreen/request_detail_screen.dart';
import 'package:employees_attendence/view/TranscriptRequestDetailPage/transcript_request_deatil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/homeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Attendance App',
      home:ApplyForTranscript(),
    );
  }
}
