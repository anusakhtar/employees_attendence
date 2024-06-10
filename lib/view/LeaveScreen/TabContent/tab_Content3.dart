
import 'package:employees_attendence/view/LeaveScreen/TabContent/widgets/itemCard.dart';
import 'package:flutter/material.dart';

class TabContent3 extends StatefulWidget {
  const TabContent3({super.key});

  @override
  State<TabContent3> createState() => _TabContent3State();
}

class _TabContent3State extends State<TabContent3> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Itemcard(
            text1: 'Casual',
            text1Color: Colors.teal,
            text2: 'Declined',
            bgColor: Colors.redAccent.withOpacity(.25),
            text2Color: Colors.redAccent,
            text3: "i will be travaling for my sister's wedding.i want to in form "
                "you that before I leave.I'll complete my ongoing projectand deliverables."
                "Also,while i'm away my team will offer the requisite support(if and whenever needed)",
          );
        });
  }
}
