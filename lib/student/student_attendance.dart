// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:attendance_app/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'database_helper.dart';

class StudentAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Start scanning the QR code
            String qrResult = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666",
              "Cancel",
              false,
              ScanMode.DEFAULT,
            );
            // Navigate to fill details page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FillDetailsPage(qrResult: qrResult),
              ),
            );
          },
          child: Text('Scan QR Code'),
        ),
      ),
    );
  }
}

class FillDetailsPage extends StatelessWidget {
  final String qrResult;

  FillDetailsPage({required this.qrResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Class: $qrResult'),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Insert attendance record into database
                await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnClassName: qrResult,
                  DatabaseHelper.columnStudentName: 'Student Name', // Get student name from text field
                  DatabaseHelper.columnDateTime: DateTime.now().toString(),
                  DatabaseHelper.columnIsPresent: 1, // Student is present
                });
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text('Submit'),
            ),
          ],
        )
      )
    );
  }
}
