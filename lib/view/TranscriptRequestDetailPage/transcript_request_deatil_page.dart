
import 'package:employees_attendence/view/RequestDetailScreen/request_detail_screen.dart';
import 'package:employees_attendence/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../widgets/apptext.dart';

class TranscriptRequest extends StatefulWidget {
  const TranscriptRequest({super.key});

  @override
  State<TranscriptRequest> createState() => _TranscriptRequestState();
}

class _TranscriptRequestState extends State<TranscriptRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: AppText(
          text: 'Request Screen',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppText(text: '28/04/2024',textAlign: TextAlign.center,fontWeight: FontWeight.w600,fontSize: 16,),
            _buildHistoryCard(context, '1', '239045', '12-06-23', 'Pending','Degree'),

          ],
        ),
      ),
    );
  }
  Widget _buildHistoryCard(BuildContext context, String sr, String Ref, String date, String status,appliedFor) {
    return Card(
      elevation: 7,
      shadowColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: GestureDetector(
        onTap: (){
          Get.to(()=>RequestDetailScreen());

        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHistoryHeader(),
              Divider(color: Colors.deepPurple.shade300, thickness: 1),
              SizedBox(height: 5),
              _buildHistoryRow(sr, Ref, date, status,appliedFor),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildHeaderItem('SR'),
        _buildHeaderItem('Ref.#'),
        _buildHeaderItem('Date'),
        _buildHeaderItem('apply'),
        _buildHeaderItem('Status'),

      ],
    );
  }

  Widget _buildHeaderItem(String text) {
    return Expanded(
      child: Center(
        child: AppText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String sr, String Ref, String date, String status,String appliedFor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRowItem(sr),
        _buildRowItem(Ref),
        _buildRowItem(date),
        _buildRowItem(appliedFor),
        _buildStatusItem(status),

      ],
    );
  }

  Widget _buildRowItem(String text) {
    return Expanded(
      child: Center(
        child: AppText(
          text: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusItem(String status) {
    Color statusColor;
    if (status == 'Paid') {
      statusColor = Colors.green;
    } else if (status == 'Pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 'Paid' ? Icons.check_circle : Icons.pending,
              color: statusColor,
              size: 12,
            ),
            SizedBox(width: 2),
            AppText(
              text: status,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              textColor: statusColor,
            ),
          ],
        ),
      ),
    );
  }
}
