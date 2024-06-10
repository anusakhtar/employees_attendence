
import 'package:employees_attendence/view/LeaveScreen/TabContent/widgets/itemCard.dart';
import 'package:flutter/material.dart';


class TabContent2 extends StatefulWidget {
  const TabContent2({super.key});

  @override
  State<TabContent2> createState() => _TabContent2State();
}

class _TabContent2State extends State<TabContent2> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context,index){
          return Itemcard(
            text1Color:Colors.orange,
            text1: 'Sick',
            text2: 'Approved',
            text3: 'I want to the hospital and the doctor confirmed that I have got[Covid-19]',
              bgColor:Colors.green.withOpacity(.24),
            text2Color: Colors.teal,
          );
        });

  }
}
