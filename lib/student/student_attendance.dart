// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, unused_import, unused_element, avoid_print

import 'package:attendance_app/components/students/student_bottom_nav_bar.dart';
import 'package:attendance_app/helpers/database_helper.dart';
import 'package:attendance_app/student/student_dashbaord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'database_helper.dart';

class StudentAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
        leading: IconButton(onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentDashboard()),
            );

        }, icon: Icon(CupertinoIcons.doc_text_search)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // You can replace this with your logout icon
            onPressed: () {
              _logout(context);
              // Perform logout action here
              // For example, you might want to clear authentication tokens and navigate to the login screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Center(
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

 void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user from Firebase
      // Navigate to the login screen or any other desired screen
      Navigator.pushReplacementNamed(context, '/login'); // Replace '/login' with the route for your login screen
    } catch (e) {
      print("Error signing out: $e");
      // Handle sign-out errors, if any
    }
  }
