// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:attendance_app/student/student_attendance.dart';
import 'package:attendance_app/student/student_dashbaord.dart';
import 'package:flutter/material.dart';


class StudentBottomBar extends StatefulWidget {
  @override
  _StudentBottomBarState createState() => _StudentBottomBarState();
}

class _StudentBottomBarState extends State<StudentBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    StudentAttendance(),
    StudentDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
