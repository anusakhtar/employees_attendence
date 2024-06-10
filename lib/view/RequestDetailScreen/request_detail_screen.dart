import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/apptext.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  List<String> progressList = ['Pending','Verification','InProgress','Issued','Delivered'];
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
          child: Column(
            children: [
              _buildStatusRow(),
              SizedBox(height: 30,),
          Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListView(
                      children: [
                        _buildInfoRow('Reference #:', _buildStyledContainer('239045', Colors.teal)),
                        _buildInfoRow('Status:', _buildStyledContainer('pending', Colors.orange)),
                        _buildInfoRow('Apply Date:', '12-06-23'),
                        _buildInfoRow('Due Date:', '12-07-23'),
                        _buildInfoRow('Issue Date:', '-'),
                        _buildInfoRow('Delivered Date:', '-'),
                        _buildInfoRow('Document #:', '-'),
                        _buildInfoRow('Application For:', _buildStyledContainer('Degree', Colors.lightGreen)),
                        _buildInfoRow('Normal/Urgent:', _buildStyledContainer('Normal', Colors.blueAccent)),
                        _buildInfoRow('Original/Duplicate:', _buildStyledContainer('Original', Colors.blueAccent)),
                        _buildInfoRow('Till Semesters:', '4'),
                        _buildInfoRow('Student Name:', 'Muhammad Anus'),
                        _buildInfoRow('Student CNIC:', '35401-2334567-1'),
                        _buildInfoRow('Date of Birth:', '12-12-2024'),
                        _buildInfoRow('Timing:', 'weekend'),
                        _buildInfoRow('Mobile Number:', '0343-1451403'),
                        _buildInfoRow('Email:', 'anusakhtar@gmail.com'),
                        _buildInfoRow('Address:', 'Minhaj university Lahore, Pipe stop'),
                        _buildInfoRow('Remarks:', '-'),
                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: value is String
                    ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.right,
                )
                    : value,
              ),
            ],
          ),
          Divider(),
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
          fontSize: 12,
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
          size: 40,
          selectedColor: _getStatusColor(currentStep),
          unselectedColor: Colors.grey,
          customStep: (index, color, _) => Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),

            child: Center(
              child: Column(
                children: [
                  Icon(
                    _getStatusIcon(index),
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(height: 2,),
                  AppText(text: progressList[index],fontSize: 8,textColor: Colors.white,),
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
