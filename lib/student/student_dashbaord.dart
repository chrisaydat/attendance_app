// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:attendance_app/helpers/database_helper.dart';
import 'package:flutter/material.dart';
// import 'database_helper.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  List<Map<String, dynamic>> attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    _getAttendanceRecords();
  }

  Future<void> _getAttendanceRecords() async {
    List<Map<String, dynamic>> records = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      attendanceRecords = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: ListView.builder(
        itemCount: attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = attendanceRecords[index];
          return ListTile(
            title: Text(record[DatabaseHelper.columnClassName]),
            subtitle: Text(record[DatabaseHelper.columnDateTime]),
            trailing: Icon(record[DatabaseHelper.columnIsPresent] == 1 ? Icons.check : Icons.close),
          );
        },
      ),
    );
  }
}
