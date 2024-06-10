
import 'package:employees_attendence/view/LeaveScreen/TabContent/widgets/itemCard.dart';
import 'package:flutter/material.dart';


class TabContent1 extends StatefulWidget {
  const TabContent1({super.key});

  @override
  State<TabContent1> createState() => _TabContent1State();
}

class _TabContent1State extends State<TabContent1> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Itemcard(
            text1: 'Vacation',
            text2: 'pending',
            text3: "i will be travaling for my sister's wedding.i want to in form "
              "you that before I leave.I'll complete my ongoing projectand deliverables."
              "Also,while i'm away my team will offer the requisite support(if and whenever needed)",
            bgColor:Colors.orange.withOpacity(.25),
            text2Color: Colors.orange,
          );
        });
  }
}
