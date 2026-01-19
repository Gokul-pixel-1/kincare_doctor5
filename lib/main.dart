import 'package:flutter/material.dart';
import 'screens/doctor_home.dart';

void main() {
  runApp(const KincareDoctorApp());
}

class KincareDoctorApp extends StatelessWidget {
  const KincareDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kincare Doctor',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DoctorHomeScreen(),
    );
  }
}