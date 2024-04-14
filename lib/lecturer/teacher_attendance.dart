// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, must_be_immutable

import 'dart:ui';
import 'package:attendance_app/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'database_helper.dart';

class TeacherAttendance extends StatelessWidget {
  String classDetails = "Math - 101"; // Sample class details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: classDetails,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Generate QR code and store class details in database
                String qrResult = classDetails;
                await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnClassName: qrResult,
                  DatabaseHelper.columnDateTime: DateTime.now().toString(),
                  DatabaseHelper.columnIsPresent: 1, // Teacher is always present
                });
              },
              child: Text('Start Class'),
            ),
          ],
        ),
      ),
    );
  }
}
