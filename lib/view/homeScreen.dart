import 'package:flutter/material.dart';

import 'AttendenceScreen/attendence_Screen.dart';
import 'LeaveScreen/leaveScreen.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myCurrentIndex = 0;
  final pages =  [
    AttendanceScreen(),
    LeaveScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[myCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        currentIndex: myCurrentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label: "Attendance"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline_rounded), label: "Leaves"),
        ],
      ),
    );
  }
}
