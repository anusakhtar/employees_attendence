import 'package:flutter/material.dart';

import '../../../../widgets/apptext.dart';



class Itemcard extends StatelessWidget {
  final String text1,text2,text3;
    final Color? bgColor,text1Color,text2Color,text3Color;
  const Itemcard(
      {super.key,
      required this.text1,
     this.bgColor,this.text1Color, required this.text2, this.text2Color, required this.text3, this.text3Color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: text1,
                textColor: text1Color ?? Colors.deepOrangeAccent,
              ),
              Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  color: bgColor ?? Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                  child: Center(child: Text(text2,style: TextStyle(color: text2Color,fontSize: 12,fontWeight: FontWeight.w400),)),),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: Colors.deepPurple,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Apr 10,2023 - Apr 15,2023',
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
              ),
            ],
          ),
          Text(
        text3,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
