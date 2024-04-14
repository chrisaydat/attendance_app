// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:attendance_app/helpers/database_helper.dart';
import 'package:flutter/material.dart';


class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  List<Map<String, dynamic>> _attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceRecords();
  }

  Future<void> _fetchAttendanceRecords() async {
    List<Map<String, dynamic>> records = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _attendanceRecords = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
      ),
      body: ListView.builder(
        itemCount: _attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = _attendanceRecords[index];
          return ListTile(
            title: Text(record[DatabaseHelper.columnClassName]),
            subtitle: Text(record[DatabaseHelper.columnStudentName]),
          );
        },
      ),
    );
  }
}
