import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final Color? boxcolor;
  const Cards({super.key, this.text1, this.text2, this.text3, this.boxcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color:boxcolor,
        borderRadius: BorderRadius.circular(10)
      ),

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text1!,style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            Text(text2!,style: TextStyle(color:Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
            Text(text3!,style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
